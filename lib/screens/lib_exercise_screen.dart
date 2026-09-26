import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/exercise.dart';
import 'package:flutter_application_1/models/exercise_set.dart';
import 'package:flutter_application_1/models/grid_exercise.dart';
import 'package:flutter_application_1/widgets/number_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibExerciseScreen extends StatefulWidget {
  final GridExercise exercise;

  const LibExerciseScreen({
    super.key,
    required this.exercise,
  });

  @override
  State<LibExerciseScreen> createState() =>
      _LibExerciseScreenState();
}

class _LibExerciseScreenState
    extends State<LibExerciseScreen> {
  // =========================================================
  // SETS
  // =========================================================

  final List<ExerciseSet> sets = [];

  @override
  void initState() {
    super.initState();

    // At least one set is always required.
    addSet();
  }

  @override
  Widget build(BuildContext context) {
    final GridExercise exercise =
        widget.exercise;

    return Scaffold(
      backgroundColor:
          const Color(0xFFE4D9D9),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 45.h,
        ),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // =========================================================
            // EXERCISE NAME
            // =========================================================

            Text(
              exercise.name,

              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 15.h),

            // =========================================================
            // EXERCISE IMAGE
            // =========================================================

            Container(
              width: double.infinity,
              height: 190.h,

              decoration: BoxDecoration(
                color: const Color.fromARGB(
                  255,
                  241,
                  233,
                  233,
                ),

                borderRadius:
                    BorderRadius.circular(12.r),

                border: Border.all(
                  color: Colors.black26,
                  width: 2,
                ),
              ),

              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(12.r),

                child: Image.asset(
                  'assets/images/exercises/${exercise.image}',

                  width: double.infinity,
                  height: double.infinity,

                  fit: BoxFit.cover,

                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 90,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // =========================================================
            // TARGET MUSCLE + DIFFICULTY
            // =========================================================

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Target Muscle :",

                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        exercise.targetMuscles
                                .isNotEmpty
                            ? exercise
                                .targetMuscles
                                .first
                            : "none",

                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 5.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Difficulty :",

                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        exercise.difficulty,

                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // =========================================================
            // SETS TITLE
            // =========================================================

            Row(
              children: const [
                Text(
                  "Sets",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),

                SizedBox(width: 25),

                Text(
                  "Weight (kg)",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),

                SizedBox(width: 40),

                Text(
                  "Reps",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight:
                        FontWeight.w300,
                  ),
                ),
              ],
            ),

            // =========================================================
            // SETS LIST
            // =========================================================

            Expanded(
              child: ListView.builder(
                itemCount: sets.length,

                itemBuilder:
                    (context, index) {
                  final ExerciseSet
                      currentSet =
                      sets[index];

                  return Padding(
                    padding:
                        const EdgeInsets.only(
                      bottom: 10,
                    ),

                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,

                          child: Text(
                            "Set ${index + 1}",

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        Expanded(
                          child: NumberField(
                            controller:
                                currentSet
                                    .weightController,

                            hintText: "Kg",
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Expanded(
                          child: NumberField(
                            controller:
                                currentSet
                                    .repsController,

                            hintText: "Reps",
                          ),
                        ),

                        const SizedBox(
                          width: 5,
                        ),

                        IconButton(
                          onPressed:
                              sets.length == 1
                                  ? null
                                  : () {
                                      removeSet(
                                        index,
                                      );
                                    },

                          icon: const Icon(
                            Icons
                                .delete_outline,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // =========================================================
            // ADD SET
            // =========================================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4B6478),

                  foregroundColor:
                      Colors.white,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      16,
                    ),
                  ),

                  elevation: 0,
                ),

                onPressed: addSet,

                child: const Text(
                  "+ Add Set",

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // =========================================================
            // CANCEL + ADD
            // =========================================================

            Row(
              children: [
                // CANCEL
                Expanded(
                  child: SizedBox(
                    height: 50.h,

                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFFEF6C6C,
                        ),

                        foregroundColor:
                            Colors.white,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16.r,
                          ),
                        ),

                        elevation: 0,
                      ),

                      onPressed: () {
                        Navigator.pop(
                          context,
                        );
                      },

                      child: Text(
                        "Cancel",

                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // ADD
                Expanded(
                  child: SizedBox(
                    height: 50.h,

                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(
                          0xFFE5DDD5,
                        ),

                        foregroundColor:
                            Colors.black,

                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16.r,
                          ),

                          side:
                              const BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),

                        elevation: 0,
                      ),

                      onPressed: () {
                        final Exercise
                            exerciseToAdd =
                            Exercise(
                          title: exercise.name,

                          muscleGroup:
                              exercise
                                  .targetMuscles
                                  .isNotEmpty
                              ? exercise
                                  .targetMuscles
                                  .first
                              : null,

                          difficulty:
                              exercise.difficulty,

                          assetImage:
                              'assets/images/exercises/${exercise.image}',
                              sets: List.from(sets),
                        );

                        Navigator.pop(
                          context,
                          exerciseToAdd,
                        );
                      },

                      child: Text(
                        "Add Exercise",

                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // ADD SET
  // =========================================================

  void addSet() {
    setState(() {
      sets.add(
        ExerciseSet(
          weightController:
              TextEditingController(),

          repsController:
              TextEditingController(),
        ),
      );
    });
  }

  // =========================================================
  // REMOVE SET
  // =========================================================

  void removeSet(int index) {
    if (sets.length == 1) {
      return;
    }

    setState(() {
      sets[index].dispose();
      sets.removeAt(index);
    });
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    for (final set in sets) {
      set.dispose();
    }

    super.dispose();
  }
}