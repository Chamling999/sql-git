DROP DATABASE IF EXISTS LibraryManagement;
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- Create tables
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    DateOfBirth DATE
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255),
    AuthorID INT,
    PublicationYear INT,
    Genre VARCHAR(50),
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Patrons (
    PatronID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    MembershipDate DATE
);

CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    PatronID INT,
    LoanDate DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (PatronID) REFERENCES Patrons(PatronID)
);

-- Insert sample data
INSERT INTO Authors (Name, DateOfBirth) VALUES
('J.K. Rowling', '1965-07-31'),
('George Orwell', '1903-06-25'),
('Jane Austen', '1775-12-16');

INSERT INTO Books (Title, AuthorID, PublicationYear, Genre) VALUES
('Harry Potter and the Sorcerer\'s Stone', 1, 1997, 'Fantasy'),
('1984', 2, 1949, 'Dystopian'),
('Pride and Prejudice', 3, 1813, 'Romance');

INSERT INTO Patrons (Name, MembershipDate) VALUES
('Alice Johnson', '2023-01-15'),
('Bob Smith', '2023-03-10'),
('Clara Lee', '2024-01-01');

INSERT INTO Loans (BookID, PatronID, LoanDate, ReturnDate) VALUES
(1, 1, '2024-01-10', NULL),
(2, 2, '2024-02-01', '2024-02-15'),
(3, 3, '2024-03-01', '2024-03-20'),
(1, 2, '2024-04-05', NULL);

-- Joins and aggregations
SELECT B.Title AS Book, A.Name AS Author
FROM Books B
JOIN Authors A ON B.AuthorID = A.AuthorID;

SELECT P.Name AS Patron, COUNT(L.BookID) AS BooksBorrowed
FROM Patrons P
JOIN Loans L ON P.PatronID = L.PatronID
GROUP BY P.Name;

SELECT 
    DATE_FORMAT(LoanDate, '%Y-%m') AS LoanMonth,
    COUNT(*) AS BooksLoaned
FROM Loans
GROUP BY LoanMonth;

-- Stored procedure to add a book and insert author if needed
DELIMITER $$

CREATE PROCEDURE AddNewBook (
    IN bookTitle VARCHAR(255),
    IN bookAuthor VARCHAR(100),
    IN authorDOB DATE,
    IN pubYear INT,
    IN genre VARCHAR(50)
)
BEGIN
    DECLARE author_id INT;
    SELECT AuthorID INTO author_id 
    FROM Authors 
    WHERE Name = bookAuthor 
    LIMIT 1;

    IF author_id IS NULL THEN
        INSERT INTO Authors (Name, DateOfBirth) 
        VALUES (bookAuthor, authorDOB);
        SET author_id = LAST_INSERT_ID();
    END IF;

    INSERT INTO Books (Title, AuthorID, PublicationYear, Genre)
    VALUES (bookTitle, author_id, pubYear, genre);
END $$

DELIMITER ;

-- Trigger to set ReturnDate when returned
DELIMITER $$

CREATE TRIGGER SetReturnDateOnUpdate
BEFORE UPDATE ON Loans
FOR EACH ROW
BEGIN
    IF OLD.ReturnDate IS NULL AND NEW.ReturnDate IS NOT NULL THEN
        SET NEW.ReturnDate = CURDATE();
    END IF;
END $$

DELIMITER ;
