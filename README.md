# 🏋️GlowUp App

A mobile application built with **Flutter & Dart** that brings **fitness and nutrition planning into one organized platform**.

Instead of keeping workouts in notes, spreadsheets, and separate meal records, **GlowUp** provides a structured way to **create, organize, edit, and manage exercises and meals** in one place.

> **Organize, design, and simplify a healthy lifestyle through exercise and nutrition.**

---

## 📱 About the Project

**GlowUp** is a mobile application designed to help users manage their personal workout and nutrition plans through two main sections:

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

---

## 📚 Libraries

**GlowUp** provides ready-made libraries to make getting started easier:

* **Exercise Library**
* **Meal Library**

Users can select items from these libraries and combine them with their own custom content when building their plans.

---

## 🧩 Custom Content

The application is not limited to predefined data.

Users can create their own custom exercises and meals.

### Custom Exercises

```text
Exercise
 ├── Name
 ├── Target Muscle
 ├── Image
 └── Sets
      ├── Weight
      └── Repetitions
```

### Custom Meals

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

The main goal of **GlowUp** is to replace scattered workout notes, meal records, and spreadsheets with **one structured application** for fitness and nutrition organization.

The core idea is:

> **One place for your workouts. One place for your meals. One organized plan.**

---

## 🛠️ Tech Stack

* **Flutter**
* **Dart**
* **Material UI**
* **BLoC / Cubit State Management**
* **JSON-based library data**
* **Local Assets**
* **SQLite** for local data persistence

---

## 📂 Main App Structure

```text
GlowUp
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

**GlowUp** is designed around a simple and organized mobile experience, with separate sections for fitness and nutrition while maintaining a consistent visual structure throughout the application.

The goal is to make creating and managing personal workout and nutrition data straightforward without unnecessary complexity.

---

## 🚀 Project Status

**Development — In Progress 🚧**

The application is currently being developed using **Flutter and Dart**.

Current development focuses on:

* UI implementation
* Exercise management
* Nutrition management
* Library data
* Custom content creation
* Plan organization
* State management
* Local data persistence

---

## 🔮 Future Development

Future development may focus on improving the application's data management, persistence, state management, and overall user experience while keeping the original purpose of **GlowUp** centered around organization and planning.

---

## 📌 Project Philosophy

> **"Instead of storing workouts in one note and meals in another, bring everything together in a single organized platform."**

---

## 👨‍💻 Built With

**Flutter & Dart**

**GlowUp** combines:

**Fitness + Nutrition + Organization**

into one mobile application.
