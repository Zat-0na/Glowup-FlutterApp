import 'dart:io';

import 'recipe_ingredient.dart';

class Recipe {
  final String title;
  final String? mealType;
  final double? totalCalories;
  final File? imageFile;
  final String? assetImage;
  final List<RecipeIngredient> ingredients;

  Recipe({
    required this.title,
    this.mealType,
    this.totalCalories,
    this.imageFile,
    this.assetImage,
    required this.ingredients,
  });
}
