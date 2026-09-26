
import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/grid_recipe.dart';

class RecipeRepository {
  final String jsonPath;

  RecipeRepository({
    this.jsonPath = 'assets/data/recipes.json',
  });

  Future<List<GridRecipe>> getRecipes() async {
    final String jsonString = await rootBundle.loadString(jsonPath);

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map(
          (item) => GridRecipe.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}

