import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  const SummaryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        width: 145.w,
        height: 130.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F4F5),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================================================
              // ICON
              // =========================================================
              Container(
                width: 27.w,
                height: 27.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0F3),
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Icon(icon, size: 16.sp, color: const Color(0xFF445E75)),
              ),

              const Spacer(),

              // =========================================================
              // TITLE
              // =========================================================
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 3.h),

              // =========================================================
              // VALUE
              // =========================================================
              Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF445E75),
                  fontSize: 22.sp,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 1.h),

              // =========================================================
              // SUBTITLE
              // =========================================================
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 9.sp,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
