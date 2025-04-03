Lane-Dane – Contact & Transaction Management App
Overview
Lane-Dane is a Flutter-based financial management application that allows users to manage personal transactions and contacts efficiently. The app is designed to provide a seamless, fast, and offline-capable experience using ObjectBox as the local database. Built with a clean and structured architecture following GetX state management, Lane-Dane ensures optimal performance and ease of use.

This application serves as a personal finance tracker, enabling users to record transactions with their contacts, categorize payments, and monitor outstanding dues. With a focus on user experience, it integrates search and filtering, transaction details tracking, and a simple, intuitive UI.

Key Features
1. Contact Management
Fetches and stores all device contacts locally in the ObjectBox database.

Displays contacts in a structured manner for easy selection.

Optimized to load contacts during the splash screen, ensuring a smooth experience.

2. Transaction Management
Allows users to create, update, and delete transactions.

Supports multiple transaction types (e.g., lending, borrowing, payments).

Stores transaction details such as amount, payment status, confirmation, and due dates.

Uses ObjectBox to ensure data is stored locally and securely, without relying on external databases.

3. Search and Filtering
Implements a real-time search bar to filter contacts by name or phone number.

Displays only relevant contacts in the SelectContact screen based on search queries.

Helps users quickly find transaction details without navigating through multiple screens.

4. Transaction History & Details
Displays a list of all transactions in a structured format on the UserTransactionIndex screen.

Clicking on a transaction opens the UserTransactionDetail screen, showing:

Profile picture of the contact.

Transaction amount, payment status, and confirmation status.

Creation date, due date, and last updated timestamp.

Options to edit or decline transactions.

5. Offline Storage & Performance Optimization
Uses ObjectBox, a high-performance local database, to ensure fast data retrieval.

Transactions and contacts are stored locally, eliminating the need for a continuous internet connection.

Fetching contacts is optimized by executing the query during app startup.

6. Secure and User-Friendly UI
Designed with Flutter’s Material UI for a smooth, native experience.

Uses GetX state management to keep business logic separate from UI components.

Ensures that permissions for accessing contacts are requested only at the start of the app, improving UX.

Technical Stack
Frontend: Flutter (Dart)

State Management: GetX

Database: ObjectBox (Local Storage)

Platform Support: Android, iOS

Architecture: MVVM (Model-View-ViewModel)

How It Works
App Launch & Contact Sync

The app fetches contacts during the splash screen and stores them in ObjectBox.

Ensures fast access when searching for contacts later.

User Creates a Transaction

Selects a contact from the SelectContact screen.

Enters transaction details such as amount, type, payment status, and due date.

Saves transaction locally.

Viewing and Managing Transactions

All transactions are displayed on the UserTransactionIndex screen.

Clicking on a transaction opens its detailed view with an option to edit or decline.

Searching for Transactions & Contacts

The search bar allows users to find contacts and transactions instantly.

Filters results based on name or phone number.

Why Lane-Dane?
Fast & Offline-First: Runs without an internet connection, making it lightweight and reliable.

Secure Data Storage: Uses ObjectBox for local storage, avoiding cloud-based dependencies.

Optimized User Experience: Fetches contacts only once, ensuring smooth and lag-free performance.

Structured Codebase: Implements GetX state management, ensuring clean and maintainable architecture.

Scalability: Designed to handle large numbers of contacts and transactions efficiently.

Potential Use Cases
Personal Finance Management: Track money borrowed, lent, or spent.

Small Business Accounting: Manage customer payments and pending dues.

Shared Expenses Tracking: Maintain records of shared expenses among friends or groups.
