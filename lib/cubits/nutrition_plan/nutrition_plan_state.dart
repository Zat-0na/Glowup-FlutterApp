import '../../models/recipe.dart';

abstract class NutritionPlanState {}

class NutritionPlanInitial extends NutritionPlanState {}

class NutritionPlanUpdated extends NutritionPlanState {
  final List<Recipe> recipes;

  NutritionPlanUpdated(this.recipes);
}

