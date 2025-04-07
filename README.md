# Expense Tracker App 💰📊

A simple yet powerful Expense Tracker built with **Flutter** and **GetX**, allowing users to record and analyze daily transactions with ease.

## 🚀 Features

- 📥 Add transactions with category, amount, date, and description
- 📄 View a running list of expenses
- 📊 Analyze total spending
- 🗑️ Delete transactions with confirmation
- 💾 Local database integration (via custom `DatabaseService`)
- ⚡ Reactive state management with GetX

## 📸 Screenshots

![Screenshot 2025-04-07 170421](https://github.com/user-attachments/assets/e6fcf9ef-3bca-4567-aa57-c0ad6bae7ed6)

![Screenshot 2025-04-07 170433](https://github.com/user-attachments/assets/3ba7fcbf-3a94-47ab-a807-0494efe1d232)

![Screenshot 2025-04-07 170445](https://github.com/user-attachments/assets/f02484f7-3542-480e-8fc8-ccde9abbe04a)

## 🧱 Tech Stack

- **Flutter**: UI Framework
- **GetX**: State Management & Navigation
- **SQLite / Hive / Custom Local Storage** (`DatabaseService`)
- **Dart**: Programming Language

## 📂 Folder Structure

lib/ ├── controllers/ │ └── transaction_controller.dart ├── models/ │ └── transaction_model.dart ├── screen/ │ ├── home_screen.dart │ ├── add_transaction_screen.dart │ └── analytics_screen.dart ├── services/ │ └── database_services.dart ├── utils/ │ ├── formatter.dart │ └── calculate.dart └── main.dart


## 🛠️ How to Run

1. Clone the repository:
   git clone https://github.com/Avii00723/expensetracker.git
   cd expense-tracker-flutter

2.Get dependencies:
   flutter pub get
3.Run the app:
  flutter run

