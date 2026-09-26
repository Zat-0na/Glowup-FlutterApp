import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/screens/create_exercisesscreen.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';
import 'package:flutter_application_1/screens/my_exercise_plan.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_application_1/cubits/workout_plan/workout_plan_cubit.dart';
import 'package:flutter_application_1/cubits/workout_plan/workout_plan_state.dart';

import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/widgets/exercise_card.dart';

class MyFitnessPlan extends StatelessWidget {
  const MyFitnessPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

      body: Stack(
        children: [
          // =========================================================
          // MAIN CONTENT
          // =========================================================

          Positioned.fill(child: _buildExercisesBody(context)),

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
                  onPressed: () async {
                    await Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => const MyExcersisePlan(),
                      ),
                    );
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
                    'Exercises',

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
          // EXERCISES BUTTON
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
                  onPressed: () {},

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
          // FITNESS TITLE
          // =========================================================
          Positioned(
            top: 42.h,
            left: 124.w,
            right: 124.w,

            child: Text(
              'Fitness',

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
          // CREATE EXERCISE BUTTON
          // =========================================================
          Positioned(
            bottom: 85.h,
            right: 15.w,

            child: Material(
              color: Colors.transparent,

              child: Container(
                height: 34.h,
                width: 88.w,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.r),

                  border: Border.all(
                    color: const Color.fromARGB(255, 52, 72, 88),

                    width: 2.8,
                  ),
                ),

                child: InkWell(
                  borderRadius: BorderRadius.circular(80.r),

                  onTap: () async {
                    final Exercise? newExercise =
                        await Navigator.push<Exercise>(
                          context,

                          MaterialPageRoute(
                            builder: (context) => const CreateExercisesScreen(),
                          ),
                        );

                    if (newExercise != null && context.mounted) {
                      context.read<WorkoutPlanCubit>().addExercise(newExercise);
                    }
                  },

                  child: Image.asset(
                    'assets/images/Icons/Custom Button.png',

                    width: 90.w,
                    height: 90.h,

                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // =========================================================
          // BOTTOM NAVIGATION
          // =========================================================
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 10.h,

            child: CustomBottomNavBar(
              currentIndex: 2,

              onItemSelected: (index) {
                if (index == 2) {
                  return;
                }

                if (index == 1) {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(
                      builder: (context) => const MyNutritionPlan(),
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
  // EXERCISES BODY
  // =========================================================

  Widget _buildExercisesBody(BuildContext context) {
    return BlocBuilder<WorkoutPlanCubit, WorkoutPlanState>(
      builder: (context, state) {
        List<Exercise> exercises = [];

        if (state is WorkoutPlanUpdated) {
          exercises = state.exercises;
        }

        return Padding(
          padding: EdgeInsets.only(top: 150.h),

          child: exercises.isEmpty
              ? Center(
                  child: Text(
                    'No exercises added yet',

                    style: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: 'Rubik',
                      color: const Color(0xFF445E75),
                    ),
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(
                    left: 37.w,
                    right: 37.w,
                    bottom: 110.h,
                  ),

                  itemCount: exercises.length,

                  itemBuilder: (context, index) {
                    final Exercise exercise = exercises[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),

                      child: ExerciseCard(
                        title: exercise.title,

                        muscleGroup: exercise.muscleGroup,

                        difficulty: exercise.difficulty,

                        imageFile: exercise.imageFile,

                        assetImage: exercise.assetImage,

                        // =================================================
                        // EDIT
                        // =================================================
                        onEdit: () async {
                          final Exercise? updatedExercise =
                              await Navigator.push<Exercise>(
                                context,

                                MaterialPageRoute(
                                  builder: (context) => CreateExercisesScreen(
                                    initialExercise: exercise,
                                  ),
                                ),
                              );

                          if (updatedExercise != null && context.mounted) {
                            context.read<WorkoutPlanCubit>().updateExercise(
                              index,
                              updatedExercise,
                            );
                          }
                        },

                        // =================================================
                        // DELETE
                        // =================================================
                        onDelete: () {
                          context.read<WorkoutPlanCubit>().removeExercise(
                            index,
                          );
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
