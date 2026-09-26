import '../../models/grid_recipe.dart';

abstract class RecipeState {}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeSuccess extends RecipeState {
  final List<GridRecipe> recipes;

  RecipeSuccess(this.recipes);
}

class RecipeFailure extends RecipeState {
  final String errorMessage;

  RecipeFailure(this.errorMessage);
}

