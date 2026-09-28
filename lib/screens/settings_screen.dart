import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/my_fitness_plan.dart';
import 'package:flutter_application_1/screens/my_nutrition_plan.dart';
import 'package:flutter_application_1/widgets/custom_buttom_navbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_application_1/cubits/profile/profile_cubit.dart';
import 'package:flutter_application_1/cubits/profile/profile_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // =========================================================
  // CONTROLLERS
  // =========================================================

  late TextEditingController _nameController;

  // =========================================================
  // UI TOGGLES
  // =========================================================

  bool darkMode = false;

  @override
  void initState() {
    super.initState();

    final currentName = context.read<ProfileCubit>().state.name;

    _nameController = TextEditingController(text: currentName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  // =========================================================
  // SAVE NAME
  // =========================================================

  void _saveName() {
    context.read<ProfileCubit>().updateName(_nameController.text);

    FocusScope.of(context).unfocus();
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

          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 5.h,
                  left: 18.w,
                  right: 18.w,
                  bottom: 115.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =====================================================
                    // HEADER
                    // =====================================================

                    _buildHeader(context),

                    SizedBox(height: 10.h),

                    // =====================================================
                    // ACCOUNT & PROFILE
                    // =====================================================
                    Text(
                      'Account & Profile',
                      style: TextStyle(
                        color: const Color(0xFF444444),
                        fontSize: 13.sp,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 7.h),

                    _buildProfileCard(),

                    SizedBox(height: 10.h),

                    // =====================================================
                    // PREFERENCES
                    // =====================================================
                    Text(
                      'Preferences',
                      style: TextStyle(
                        color: const Color(0xFF444444),
                        fontSize: 13.sp,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    _buildPreferencesCard(),

                    SizedBox(height: 10.h),

                    // =====================================================
                    // SUPPORT
                    // =====================================================
                    Text(
                      'Support',
                      style: TextStyle(
                        color: const Color(0xFF444444),
                        fontSize: 13.sp,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 5.h),

                    _buildSupportCard(),
                  ],
                ),
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
              currentIndex: 3,

              onItemSelected: (index) {
                // =====================================================
                // HOME
                // =====================================================

                if (index == 0) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
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

                // =====================================================
                // SETTINGS
                // =====================================================

                if (index == 3) {
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
  // HEADER
  // ================================================================

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 125.h,
      decoration: BoxDecoration(
        color: const Color(0xFF49647B),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Stack(
        children: [
          // ---------------------------------------------------------
          // BELL
          // ---------------------------------------------------------
          Positioned(
            left: 15.w,
            top: 30.h,
            child: Icon(
              Icons.notifications_rounded,
              color: Colors.white,
              size: 20.sp,
            ),
          ),

          // ---------------------------------------------------------
          // TITLE
          // ---------------------------------------------------------
          Positioned(
            top: 45.h,
            left: 0.w,
            right: 0.w,
            child: Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          // ---------------------------------------------------------
          // PROFILE ICON
          // ---------------------------------------------------------
          Positioned(
            right: 15.w,
            top: 30.h,
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
        ],
      ),
    );
  }

  // ================================================================
  // PROFILE CARD
  // ================================================================

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(14.w, 10.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFB),
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ==========================================================
          // PROFILE IMAGE
          // ==========================================================

          Container(
            width: 58.w,
            height: 58.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE4E4E4),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Icon(
              Icons.person,
              color: const Color(0xFF53697A),
              size: 32.sp,
            ),
          ),

          SizedBox(height: 8.h),

          // ==========================================================
          // NAME
          // ==========================================================
          _buildTextField(
            controller: _nameController,
            label: 'Name',
            onSubmitted: (_) => _saveName(),
          ),

          SizedBox(height: 7.h),

          // ==========================================================
          // AGE - UI ONLY
          // ==========================================================
          _buildStaticField(label: 'Age', value: '30'),

          SizedBox(height: 7.h),

          // ==========================================================
          // WEIGHT - UI ONLY
          // ==========================================================
          _buildStaticField(label: 'Weight', value: '75 kg'),
        ],
      ),
    );
  }

  // ================================================================
  // PREFERENCES
  // ================================================================

  Widget _buildPreferencesCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFB),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // ==========================================================
          // DARK MODE
          // ==========================================================

          _buildPreferenceRow(
            title: 'Theme',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                  value: darkMode,
                  onChanged: (value) {
                    setState(() {
                      darkMode = value;
                    });
                  },
                  activeThumbColor: const Color(0xFF445E75),
                ),
                Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontFamily: 'Rubik',
                  ),
                ),
              ],
            ),
          ),

          // ==========================================================
          // UNITS
          // ==========================================================
          _buildPreferenceRow(
            title: 'Units',
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'Imperial / Metric',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ),

          // ==========================================================
          // LANGUAGE
          // ==========================================================
          _buildPreferenceRow(
            title: 'Language',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'English (US)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10.sp,
                    fontFamily: 'Rubik',
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18.sp,
                  color: const Color(0xFF445E75),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SUPPORT
  // ================================================================

  Widget _buildSupportCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFDFBFB),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSupportRow('Help Center'),

          _buildSupportRow('Send Feedback'),

          _buildSupportRow('Terms of Service'),

          _buildSupportRow('About App', trailingText: 'Version 1.2.0'),
        ],
      ),
    );
  }

  // ================================================================
  // TEXT FIELD
  // ================================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required ValueChanged<String> onSubmitted,
  }) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      style: TextStyle(
        color: Colors.black,
        fontSize: 12.sp,
        fontFamily: 'Rubik',
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black, fontSize: 10.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 3.h),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: Color(0xFF445E75)),
        ),
      ),
    );
  }

  // ================================================================
  // STATIC FIELD
  // ================================================================

  Widget _buildStaticField({required String label, required String value}) {
    return Container(
      width: double.infinity,
      height: 32.h,
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 10.sp,
              fontFamily: 'Rubik',
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12.sp,
              fontFamily: 'Rubik',
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // PREFERENCE ROW
  // ================================================================

  Widget _buildPreferenceRow({
    required String title,
    required Widget trailing,
  }) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 0.7),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 11.sp,
              fontFamily: 'Rubik',
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }

  // ================================================================
  // SUPPORT ROW
  // ================================================================

  Widget _buildSupportRow(String title, {String? trailingText}) {
    return InkWell(
      onTap: () {
        // UI only for now.
      },
      child: Container(
        height: 38.h,
        padding: EdgeInsets.symmetric(horizontal: 11.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 0.7),
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 10.sp,
                fontFamily: 'Rubik',
              ),
            ),

            const Spacer(),

            if (trailingText != null)
              Text(
                trailingText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 9.sp,
                  fontFamily: 'Rubik',
                ),
              ),

            SizedBox(width: 4.w),

            Icon(
              Icons.chevron_right_rounded,
              color: const Color(0xFF445E75),
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
