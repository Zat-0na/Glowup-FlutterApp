import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/create_exercisesscreen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_application_1/cubits/exercise/exercise_cubit.dart';
import 'package:flutter_application_1/cubits/exercise/exercise_state.dart';
import 'package:flutter_application_1/cubits/workout_plan/workout_plan_cubit.dart';

import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/exercise_set.dart';
import 'package:flutter_application_1/models/grid_exercise.dart';

import 'package:flutter_application_1/screens/lib_exercise_screen.dart';

import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_application_1/widgets/grid_cards_widget.dart';

class MyExcersisePlan extends StatefulWidget {
  const MyExcersisePlan({super.key});

  @override
  State<MyExcersisePlan> createState() => _MyExcersisePlanState();
}

class _MyExcersisePlanState extends State<MyExcersisePlan> {
  final int _currentIndex = 2;

  @override
  void initState() {
    super.initState();

    // =========================================================
    // LOAD EXERCISE LIBRARY
    // =========================================================

    context.read<ExerciseCubit>().getExercises();
  }

  // =========================================================
  // CONVERT LIBRARY EXERCISE TO EXERCISE MODEL
  // =========================================================

  Exercise convertToExercise(GridExercise gridExercise) {
    return Exercise(
      title: gridExercise.name,

      muscleGroup: gridExercise.targetMuscles.join(', '),

      difficulty: gridExercise.difficulty,

      sets: [
        ExerciseSet(
          weightController: TextEditingController(),

          repsController: TextEditingController(),
        ),
      ],

      assetImage: 'assets/images/exercises/${gridExercise.image}',
    );
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
              height: 125.h,

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
            top: 95.h,

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
            top: 95.h,

            child: Opacity(
              opacity: 0.90,

              child: SizedBox(
                width: 78.w,
                height: 26.h,

                child: ElevatedButton(
                  onPressed: () {
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
          // FITNESS TITLE
          // =========================================================
          Positioned(
            top: 55.h,
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

          // ---------------------------------------------------
          // BELL
          // ---------------------------------------------------
          Positioned(
            left: 35.w,
            top: 45.h,
            child: Icon(
              Icons.notifications_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),

          // ---------------------------------------------------
          // PROFILE
          // ---------------------------------------------------
          Positioned(
            right: 35.w,
            top: 45.h,
            child: GestureDetector(
              onTap: () {
                // Settings will be connected later.
              },
              child: Container(
                width: 23.w,
                height: 23.w,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: const Color(0xFF49647B),
                  size: 17.sp,
                ),
              ),
            ),
          ),

          // =========================================================
          // CREATE EXERCISE BUTTON
          // =========================================================
          // if (_currentIndex == 2)
          // Positioned(
          //   bottom: 85.h,
          //   right: 15.w,
          //   child: Material(
          //     color: Colors.transparent,
          //     child: Container(
          //       height: 34.h,
          //       width: 88.w,
          //       decoration: BoxDecoration(
          //         borderRadius:
          //             BorderRadius.circular(9.r),
          //         border: Border.all(
          //           color:
          //               const Color.fromARGB(
          //             255,
          //             52,
          //             72,
          //             88,
          //           ),
          //           width: 2.8,
          //         ),
          //       ),
          //       child: InkWell(
          //         borderRadius:
          //             BorderRadius.circular(80.r),
          //         onTap: () async {
          //           final Exercise?
          //               newExercise =
          //               await Navigator.push<
          //                   Exercise>(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) =>
          //                   const CreateExercisesScreen(),
          //             ),
          //           );
          //           if (newExercise !=
          //                   null &&
          //               context.mounted) {
          //             context
          //                 .read<
          //                     WorkoutPlanCubit>()
          //                 .addExercise(
          //                   newExercise,
          //                 );
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
                if (index == 0) {
                  Navigator.pushReplacement(
                    context,

                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                }

                if (index == 3) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  );
                  return;
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
        return const Center(child: Text('Foods Screen'));

      case 2:
        return _buildBodyContent();

      case 3:
        return const Center(child: Text('Statistics Screen'));

      default:
        return _buildBodyContent();
    }
  }

  // =========================================================
  // EXERCISE LIBRARY
  // =========================================================

  Widget _buildBodyContent() {
    return BlocBuilder<ExerciseCubit, ExerciseState>(
      builder: (context, state) {
        if (state is ExerciseLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ExerciseFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        if (state is ExerciseSuccess) {
          final List<GridExercise> exercises = state.exercises;

          return GridCardsWidget<GridExercise>(
            items: exercises,

            getId: (exercise) => exercise.id,

            getTitle: (exercise) => exercise.name,

            getImage: (exercise) => 'assets/images/exercises/${exercise.image}',

            onItemTap: (exercise) {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) => LibExerciseScreen(exercise: exercise),
                ),
              );
            },

            onItemsSelected: (selectedExercises) {
              final WorkoutPlanCubit workoutPlanCubit = context
                  .read<WorkoutPlanCubit>();

              for (final GridExercise gridExercise in selectedExercises) {
                final Exercise exercise = convertToExercise(gridExercise);

                workoutPlanCubit.addExercise(exercise);
              }
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
