import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/create_recipes_screen.dart';
import 'package:flutter_application_1/screens/my_fitness_plan.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubits/recipe/recipe_cubit.dart';
import 'package:flutter_application_1/cubits/recipe/recipe_state.dart';
import 'package:flutter_application_1/cubits/nutrition_plan/nutrition_plan_cubit.dart';
import 'package:flutter_application_1/models/grid_recipe.dart';
import 'package:flutter_application_1/models/recipe.dart';
import 'package:flutter_application_1/screens/lib_recipe_screen.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_application_1/widgets/grid_cards_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyRecipePlan extends StatefulWidget {
  const MyRecipePlan({super.key});

  @override
  State<MyRecipePlan> createState() => _MyRecipePlanState();
}

class _MyRecipePlanState extends State<MyRecipePlan> {
  final int _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    context.read<RecipeCubit>().getRecipes();
  }

  // =========================================================
  // ADD SELECTED RECIPES TO NUTRITION PLAN
  // =========================================================

  void _addSelectedRecipes(List<GridRecipe> selectedRecipes) {
    final nutritionPlanCubit = context.read<NutritionPlanCubit>();

    for (final gridRecipe in selectedRecipes) {
      final Recipe recipe = Recipe(
        title: gridRecipe.title,
        mealType: gridRecipe.mealType,
        totalCalories: gridRecipe.totalCalories,
        ingredients: [],
        assetImage: 'assets/images/recipes/${gridRecipe.image}',
      );

      nutritionPlanCubit.addRecipe(recipe);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

      body: Stack(
        children: [
          // =========================================================
          // MAIN CONTENT
          // =========================================================

          Positioned.fill(child: _buildCurrentScreenContent()),

          // =========================================================
          // HEADER
          // =========================================================
          Positioned(
            top: 22.h,
            left: 18.w,
            right: 18.w,
            child: Container(
              width: double.infinity,
              height: 111.h,

              decoration: ShapeDecoration(
                color: const Color(0xFF445E75),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
              ),
            ),
          ),

          // =========================================================
          // MY PLAN BUTTON
          // =========================================================
          Positioned(
            left: 90.w,
            top: 75.h,
            child: Opacity(
              opacity: 0.90,

              child: SizedBox(
                width: 78.w,
                height: 26.h,

                child: ElevatedButton(
                  onPressed: () {
                    // The current screen is the Recipes library.
                    // My Plan is handled by the Nutrition Plan screen.
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF7F7),

                    elevation: 0,

                    padding: EdgeInsets.zero,

                    side: const BorderSide(width: 2, color: Color(0xFF445E75)),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),

                  child: Text(
                    'Recipes',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // =========================================================
          // RECIPES BUTTON
          // =========================================================
          Positioned(
            left: 190.w,
            top: 75.h,
            child: Opacity(
              opacity: 0.90,

              child: SizedBox(
                width: 78.w,
                height: 26.h,

                child: ElevatedButton(
                  onPressed: () {
                    // The current screen is the Recipes library.
                    // My Plan is handled by the Nutrition Plan screen.
                    Navigator.pop(context);
                  },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF7F7),

                    elevation: 0,

                    padding: EdgeInsets.zero,

                    side: const BorderSide(width: 2, color: Color(0xFF445E75)),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),

                  child: Text(
                    'My Plan',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // =========================================================
          // NUTRITION TITLE
          // =========================================================
          Positioned(
            top: 42.h,
            left: 110.w,
            right: 110.w,

            child: Text(
              'Nutrition',
              textAlign: TextAlign.center,

              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // =========================================================
          // CREATE RECIPE BUTTON
          // =========================================================
          // Positioned(
          //   bottom: 85.h,
          //   right: 15.w,

          //   child: Material(
          //     color: Colors.transparent,

          //     child: Container(
          //       height: 34.h,
          //       width: 88.w,

          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(9.r),

          //         border: Border.all(
          //           color: const Color.fromARGB(255, 52, 72, 88),
          //           width: 2.8,
          //         ),
          //       ),

          //       child: InkWell(
          //         borderRadius: BorderRadius.circular(80.r),

          //         onTap: () async {
          //           final Recipe? newRecipe = await Navigator.push<Recipe>(
          //             context,

          //             MaterialPageRoute(
          //               builder: (context) => const CreateRecipesScreen(),
          //             ),
          //           );

          //           if (newRecipe != null && context.mounted) {
          //             context.read<NutritionPlanCubit>().addRecipe(newRecipe);
          //           }
          //         },

          //         child: Image.asset(
          //           'assets/images/Icons/Custom Button.png',

          //           width: 90.w,
          //           height: 90.h,

          //           fit: BoxFit.contain,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // =========================================================
          // BOTTOM NAVIGATION
          // =========================================================
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 10.h,

            child: CustomBottomNavBar(
              currentIndex: 1,

              onItemSelected: (index) {
                if (index == 1) {
                  return;
                }

                if (index == 2) {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(
                      builder: (context) => const MyFitnessPlan(),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // CURRENT SCREEN CONTENT
  // =========================================================

  Widget _buildCurrentScreenContent() {
    switch (_currentIndex) {
      case 0:
        return const Center(child: Text('Daily Screen'));

      case 1:
        return _buildRecipesContent();

      case 2:
        return const Center(child: Text('Fitness Screen'));

      case 3:
        return const Center(child: Text('Statistics Screen'));

      default:
        return _buildRecipesContent();
    }
  }

  // =========================================================
  // RECIPES LIBRARY
  // =========================================================

  Widget _buildRecipesContent() {
    return BlocBuilder<RecipeCubit, RecipeState>(
      builder: (context, state) {
        if (state is RecipeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is RecipeFailure) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(20.w),

              child: Text(
                'Failed to load recipes\n\n'
                '${state.errorMessage}',

                textAlign: TextAlign.center,

                style: TextStyle(fontFamily: 'Rubik', fontSize: 14.sp),
              ),
            ),
          );
        }

        if (state is RecipeSuccess) {
          return GridCardsWidget<GridRecipe>(
            items: state.recipes,

            getId: (recipe) => recipe.id,

            getTitle: (recipe) => recipe.title,

            getImage: (recipe) => 'assets/images/recipes/${recipe.image}',

            onItemTap: (recipe) {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => LibRecipeScreen(recipe: recipe),
                ),
              );
            },

            onItemsSelected: (selectedRecipes) {
              _addSelectedRecipes(selectedRecipes);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
