import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/recipe.dart';
import 'nutrition_plan_state.dart';

class NutritionPlanCubit extends Cubit<NutritionPlanState> {
  final List<Recipe> _recipes = [];

  NutritionPlanCubit() : super(NutritionPlanInitial());

  List<Recipe> get recipes => List.unmodifiable(_recipes);

  void addRecipe(Recipe recipe) {
    // Prevent duplicate recipes by title
    final alreadyExists = _recipes.any(
      (item) => item.title == recipe.title,
    );

    if (alreadyExists) {
      return;
    }

    _recipes.add(recipe);

    emit(
      NutritionPlanUpdated(
        List.from(_recipes),
      ),
    );
  }

  void removeRecipe(int index) {
    if (index < 0 || index >= _recipes.length) {
      return;
    }

    _recipes.removeAt(index);

    emit(
      NutritionPlanUpdated(
        List.from(_recipes),
      ),
    );
  }

  void updateRecipe(
    int index,
    Recipe updatedRecipe,
  ) {
    if (index < 0 || index >= _recipes.length) {
      return;
    }

    _recipes[index] = updatedRecipe;

    emit(
      NutritionPlanUpdated(
        List.from(_recipes),
      ),
    );
  }

  void clearPlan() {
    _recipes.clear();

    emit(
      NutritionPlanUpdated(
        List.from(_recipes),
      ),
    );
  }
}

