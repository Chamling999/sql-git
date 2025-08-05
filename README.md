# Library Management System (SQL)

This project provides a simple Library Management System implemented in SQL. It demonstrates the creation of a relational database schema, insertion of sample data, and the use of SQL features such as joins, aggregations, stored procedures, and triggers.

## Database Structure

The database is named `LibraryManagement` and contains the following tables:

### 1. Authors
- `AuthorID` (INT, Primary Key, Auto Increment): Unique identifier for each author.
- `Name` (VARCHAR(100)): Name of the author.
- `DateOfBirth` (DATE): Date of birth of the author.

### 2. Books
- `BookID` (INT, Primary Key, Auto Increment): Unique identifier for each book.
- `Title` (VARCHAR(255)): Title of the book.
- `AuthorID` (INT, Foreign Key): References `Authors(AuthorID)`.
- `PublicationYear` (INT): Year the book was published.
- `Genre` (VARCHAR(50)): Genre of the book.

### 3. Patrons
- `PatronID` (INT, Primary Key, Auto Increment): Unique identifier for each library patron.
- `Name` (VARCHAR(100)): Name of the patron.
- `MembershipDate` (DATE): Date the patron joined the library.

### 4. Loans
- `LoanID` (INT, Primary Key, Auto Increment): Unique identifier for each loan transaction.
- `BookID` (INT, Foreign Key): References `Books(BookID)`.
- `PatronID` (INT, Foreign Key): References `Patrons(PatronID)`.
- `LoanDate` (DATE): Date the book was loaned.
- `ReturnDate` (DATE): Date the book was returned (NULL if not yet returned).

## Sample Data

The script inserts sample data for authors, books, patrons, and loans to demonstrate the functionality of the system.

## Queries and Features

- **Joins:**
  - List all books with their authors.
- **Aggregations:**
  - Count the number of books borrowed by each patron.
  - Count the number of books loaned per month.
- **Stored Procedure:**
  - `AddNewBook`: Adds a new book to the library. If the author does not exist, it inserts the author first.
- **Trigger:**
  - `SetReturnDateOnUpdate`: Automatically sets the `ReturnDate` to the current date when a book is returned (when `ReturnDate` is updated from NULL to a value).

## How to Use

1. **Run the SQL Script:**
   - Execute the `librarymanagement.sql` file in your MySQL environment. This will create the database, tables, sample data, stored procedure, and trigger.
2. **Modify or Extend:**
   - You can add more sample data, queries, or extend the schema as needed for your use case.

## Requirements
- MySQL or compatible SQL database server.

## Notes
- The script uses `AUTO_INCREMENT` for primary keys and assumes MySQL syntax (e.g., `DELIMITER`, `DATE_FORMAT`).
- The trigger and stored procedure are written for MySQL. Adjustments may be needed for other SQL dialects.


## Author
Chamling Manita