# 🏋️GlowUp App

A mobile application built with **Flutter & Dart** that brings **fitness and nutrition planning into one organized platform**.

Instead of keeping workouts in notes, spreadsheets, and separate meal records, the app provides a structured way to **create, organize, edit, and manage exercises and meals** in one place.

> **Organize, design, and simplify a healthy lifestyle through exercise and nutrition.**

---

## 📱 About the Project

**Fitness & Nutrition Organizer** is designed to help users manage their personal workout and nutrition plans through two main sections:

* 🏋️ **Fitness**
* 🍎 **Nutrition**

The application focuses on **organization and planning**, rather than coaching or automated decision-making.

Users can choose items from built-in libraries or create their own custom exercises and meals, then combine them into personalized plans.

---

## ✨ Features

### 🏋️ Fitness

* Browse a built-in **Exercise Library**
* Create custom exercises
* Edit custom exercises
* Add exercise images
* Specify target muscle groups
* Add multiple sets
* Record repetitions
* Record weight for each set
* Organize exercises into personal fitness plans

### 🍎 Nutrition

* Browse a predefined **Meal Library**
* Create custom meals
* Edit custom meals
* Add meal images
* Add ingredients
* Specify ingredient quantities
* Manage calories and macronutrients:

  * 🥩 Protein
  * 🍚 Carbohydrates
  * 🥑 Fats
* Automatically update nutritional values when ingredient quantities change
* Organize meals into personal nutrition plans

These features are based on the project's defined scope and requirements.

---

## 📚 Libraries

The application provides ready-made libraries to make getting started easier:

* **Exercise Library**
* **Meal Library**

Users can select items from these libraries and combine them with their own custom content when building their plans.

---

## 🧩 Custom Content

The application is not limited to predefined data.

Users can create their own:

**Custom Exercises**

```text
Exercise
 ├── Name
 ├── Target Muscle
 ├── Image
 └── Sets
      ├── Weight
      └── Repetitions
```

**Custom Meals**

```text
Meal
 ├── Name
 ├── Image
 └── Ingredients
      ├── Ingredient Name
      ├── Weight
      ├── Calories
      ├── Protein
      ├── Carbohydrates
      └── Fats
```

---

## 🎯 Project Goal

The main goal is to replace scattered workout notes, meal records, and spreadsheets with **one structured application** for fitness and nutrition organization.

The core idea is:

> **One place for your workouts. One place for your meals. One organized plan.**

---

## 🛠️ Tech Stack

* **Flutter**
* **Dart**
* **Material UI**
* **Bloc/Cubit Statemanagment**
* **JSON-based library data**
* **Local assets**
* [local SQLite database](https://www.prisma.io/dataguide/sqlite/setting-up-a-local-sqlite-database)

---

## 📂 Main App Structure

```text
Fitness & Nutrition Organizer
│
├── Fitness
│   ├── Exercise Library
│   ├── Custom Exercises
│   └── Fitness Plans
│
└── Nutrition
    ├── Meal Library
    ├── Custom Meals
    └── Nutrition Plans
```

---

## 🎨 UI & Design

The application is designed around a simple and organized mobile experience, with separate sections for fitness and nutrition while maintaining a consistent visual structure throughout the app.

The goal is to make creating and managing personal workout and nutrition data straightforward without unnecessary complexity.

---

## 🚀 Project Status

**Development — In Progress 🚧**

The application is currently being developed using Flutter and Dart.

Current development focuses on:

* UI implementation
* Exercise management
* Nutrition management
* Library data
* Custom content creation
* Plan organization
* Local data structure

---

## 🔮 Future Development

Future development may focus on improving the application's data management, state management, persistence, and overall user experience while keeping the original purpose of the project centered around organization and planning.

---

## 📌 Project Philosophy

> **"Instead of storing workouts in one note and meals in another, bring everything together in a single organized platform."**

---

## 👨‍💻 Built With

**Flutter & Dart**

Created as a mobile application project focused on combining **Fitness + Nutrition + Organization** into one platform.
