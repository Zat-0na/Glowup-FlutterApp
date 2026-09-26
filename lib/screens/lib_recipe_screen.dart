import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/grid_recipe.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LibRecipeScreen extends StatefulWidget {
  final GridRecipe recipe;

  const LibRecipeScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<LibRecipeScreen> createState() =>
      _LibRecipeScreenState();
}

class _LibRecipeScreenState
    extends State<LibRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    final GridRecipe recipe = widget.recipe;

    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

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
            // RECIPE NAME
            // =========================================================

            Text(
              recipe.title,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            SizedBox(height: 15.h),

            // =========================================================
            // RECIPE IMAGE
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
                  'assets/images/recipes/${recipe.image}',

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
            // MEAL TYPE + CALORIES
            // =========================================================

            Row(
              children: [
                // MEAL TYPE
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Meal Type :",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        recipe.mealType,
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

                // CALORIES
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        "Calories :",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),

                      SizedBox(height: 8.h),

                      Text(
                        "${recipe.totalCalories.toStringAsFixed(0)} kcal",
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

            SizedBox(height: 20.h),

            // =========================================================
            // RECIPE INFORMATION
            // =========================================================

            Text(
              "Recipe Information",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10.h),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(16.w),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1E9E9),
                    borderRadius:
                        BorderRadius.circular(16.r),
                    border: Border.all(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),

                  child: Text(
                    "This recipe is a "
                    "${recipe.mealType.toLowerCase()} "
                    "with approximately "
                    "${recipe.totalCalories.toStringAsFixed(0)} "
                    "calories.",
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 1.5,
                      color: Colors.black87,
                    ),
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
                            const Color(0xFFEF6C6C),
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
                        Navigator.pop(context);
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
                            const Color(0xFFE5DDD5),
                        foregroundColor:
                            Colors.black,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            16.r,
                          ),
                          side: const BorderSide(
                            color: Colors.black54,
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                      ),

                      onPressed: () {
                        Navigator.pop(
                          context,
                          recipe,
                        );
                      },

                      child: Text(
                        "Add Recipe",
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
}
