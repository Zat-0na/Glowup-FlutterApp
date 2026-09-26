import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/grid_recipe.dart';
import '../../repositories/recipe_repository.dart';
import 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final RecipeRepository recipeRepository;

  RecipeCubit(this.recipeRepository)
      : super(RecipeInitial());

  Future<void> getRecipes() async {
    emit(RecipeLoading());

    try {
      final List<GridRecipe> recipes =
          await recipeRepository.getRecipes();

      emit(
        RecipeSuccess(recipes),
      );
    } catch (e) {
      emit(
        RecipeFailure(
          e.toString(),
        ),
      );
    }
  }
}

