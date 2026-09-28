import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubits/profile/profile_cubit.dart';
import 'package:flutter_application_1/cubits/profile/profile_state.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// =========================================================
// CUBITS
// =========================================================
import 'package:flutter_application_1/cubits/workout_plan/workout_plan_cubit.dart';
import 'package:flutter_application_1/cubits/workout_plan/workout_plan_state.dart';

import 'package:flutter_application_1/cubits/nutrition_plan/nutrition_plan_cubit.dart';
import 'package:flutter_application_1/cubits/nutrition_plan/nutrition_plan_state.dart';

// =========================================================
// SCREENS
// =========================================================
import 'package:flutter_application_1/screens/my_fitness_plan.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';

// =========================================================
// WIDGETS
// =========================================================
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_application_1/widgets/summary_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // =========================================================
  // HYDRATION
  // =========================================================

  int glasses = 0;

  static const int maxGlasses = 8;

  void _addGlass() {
    if (glasses < maxGlasses) {
      setState(() {
        glasses++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4D9D9),

      body: Stack(
        children: [
          // =========================================================
          // MAIN BODY
          // =========================================================

          Positioned.fill(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 165.h,
                left: 30.w,
                right: 30.w,
                bottom: 115.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // GREETING
                  // =====================================================

                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return Text(
                        'Good morning, ${state.name} 👋',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.sp,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    'Ready to work on your goals?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // =====================================================
                  // SUMMARY CARDS
                  // =====================================================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // -------------------------------------------------
                      // WORKOUT CARD
                      // -------------------------------------------------

                      BlocBuilder<WorkoutPlanCubit, WorkoutPlanState>(
                        builder: (context, state) {
                          int exerciseCount = 0;

                          if (state is WorkoutPlanUpdated) {
                            exerciseCount = state.exercises.length;
                          }

                          return SummaryCard(
                            icon: Icons.fitness_center_rounded,
                            title: 'My Fitness',
                            value: '$exerciseCount',
                            subtitle: exerciseCount == 1
                                ? 'Exercise in your plan'
                                : 'Exercises in your plan',
                          );
                        },
                      ),
                      SizedBox(width: 5.h),

                      // -------------------------------------------------
                      // NUTRITION CARD
                      // -------------------------------------------------
                      BlocBuilder<NutritionPlanCubit, NutritionPlanState>(
                        builder: (context, state) {
                          int recipeCount = 0;

                          if (state is NutritionPlanUpdated) {
                            recipeCount = state.recipes.length;
                          }

                          return SummaryCard(
                            icon: Icons.restaurant_rounded,
                            title: 'My Nutrition',
                            value: '$recipeCount',
                            subtitle: recipeCount == 1
                                ? 'Recipe in your plan'
                                : 'Recipes in your plan',
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 25.h),

                  // =====================================================
                  // HYDRATION
                  // =====================================================
                  _buildHydrationCard(),

                  SizedBox(height: 15.h),

                  // =====================================================
                  // QUICK ACCESS
                  // =====================================================
                  _buildQuickAccess(),
                ],
              ),
            ),
          ),

          // ===========================================================
          // HEADER
          // ===========================================================
          Positioned(
            top: 22.h,
            left: 18.w,
            right: 18.w,
            child: Container(
              height: 125.h,
              decoration: BoxDecoration(
                color: const Color(0xFF49647B),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Stack(
                children: [
                  // ---------------------------------------------------
                  // BELL
                  // ---------------------------------------------------
                  Positioned(
                    left: 15.w,
                    top: 30.h,
                    child: Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),

                  // ---------------------------------------------------
                  // TITLE
                  // ---------------------------------------------------
                  Positioned(
                    top: 45.h,
                    left: 124.w,
                    right: 124.w,
                    child: Text(
                      'Home',
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
                  // PROFILE
                  // ---------------------------------------------------
                  Positioned(
                    right: 15.w,
                    top: 30.h,
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
                ],
              ),
            ),
          ),

          // ===========================================================
          // BOTTOM NAVIGATION
          // ===========================================================
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 10.h,
            child: CustomBottomNavBar(
              currentIndex: 0,
              onItemSelected: (index) {
                // =====================================================
                // DAILY / HOME
                // =====================================================

                if (index == 0) {
                  return;
                }

                // =====================================================
                // FOODS
                // =====================================================

                if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyNutritionPlan(),
                    ),
                  );
                  return;
                }

                // =====================================================
                // EXERCISES
                // =====================================================

                if (index == 2) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyFitnessPlan(),
                    ),
                  );
                  return;
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

  // ================================================================
  // HYDRATION CARD
  // ================================================================

  Widget _buildHydrationCard() {
    final double progress = glasses / maxGlasses;

    return Container(
      width: double.infinity,
      height: 75.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFB),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.black, width: 0.8),
      ),
      child: Column(
        children: [
          // ============================================================
          // TOP ROW
          // ============================================================

          Row(
            children: [
              Text(
                'Hydration',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(width: 12.w),

              Text(
                '$glasses / $maxGlasses Glasses',
                style: TextStyle(
                  color: const Color(0xFF445E75),
                  fontSize: 8.sp,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(width: 6.w),

              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5.h,
                    backgroundColor: const Color(0xFFE2E1E1),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF445E75),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // ============================================================
          // ADD GLASS BUTTON
          // ============================================================
          SizedBox(
            width: double.infinity,
            height: 20.h,
            child: ElevatedButton(
              onPressed: _addGlass,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF49647B),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.r),
                ),
              ),
              child: Icon(Icons.water_drop_rounded, size: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // QUICK ACCESS
  // ================================================================

  Widget _buildQuickAccess() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFB),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: Colors.black, width: 0.8),
      ),
      child: Column(
        children: [
          // ============================================================
          // TITLE
          // ============================================================

          Padding(
            padding: EdgeInsets.only(left: 14.w, top: 8.h, bottom: 5.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick Access',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // ============================================================
          // FITNESS PLAN
          // ============================================================
          _buildQuickAccessItem(
            icon: Icons.fitness_center_rounded,
            title: 'My Fitness Plan',
            subtitle: 'View and manage your exercises',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyFitnessPlan()),
              );
            },
          ),

          // ============================================================
          // NUTRITION PLAN
          // ============================================================
          _buildQuickAccessItem(
            icon: Icons.restaurant_rounded,
            title: 'My Nutrition Plan',
            subtitle: 'View your meals and recipes',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyNutritionPlan(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ================================================================
  // QUICK ACCESS ITEM
  // ================================================================

  Widget _buildQuickAccessItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 43.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.shade400, width: 0.7),
          ),
        ),
        child: Row(
          children: [
            // ==========================================================
            // ICON
            // ==========================================================

            Container(
              width: 23.w,
              height: 23.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0F3),
                borderRadius: BorderRadius.circular(3.r),
              ),
              child: Icon(icon, color: const Color(0xFF445E75), size: 14.sp),
            ),

            SizedBox(width: 8.w),

            // ==========================================================
            // TEXT
            // ==========================================================
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 9.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 7.sp,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // ==========================================================
            // ARROW
            // ==========================================================
            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF445E75),
              size: 19.sp,
            ),
          ],
        ),
      ),
    );
  }
}
