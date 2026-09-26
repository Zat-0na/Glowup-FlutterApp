import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/screens/my_fitness_plan.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Repositories
import 'repositories/exercise_repository.dart';
import 'repositories/recipe_repository.dart';

// Cubits
import 'cubits/exercise/exercise_cubit.dart';
import 'cubits/workout_plan/workout_plan_cubit.dart';
import 'cubits/recipe/recipe_cubit.dart';
import 'cubits/nutrition_plan/nutrition_plan_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(358, 661),
      child: MultiBlocProvider(
        providers: [
          // Exercise Library
          BlocProvider(
            create: (context) => ExerciseCubit(
              ExerciseRepository(),
            ),
          ),

          // Workout Plan
          BlocProvider(
            create: (context) => WorkoutPlanCubit(),
          ),

          // Recipe Library
          BlocProvider(
            create: (context) => RecipeCubit(
              RecipeRepository(),
            ),
          ),

          // Nutrition Plan
          BlocProvider(
            create: (context) => NutritionPlanCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
          ),
          home: const MyNutritionPlan(),
        ),
      ),
    );
  }
}

