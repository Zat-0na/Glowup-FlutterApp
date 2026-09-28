import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseCard extends StatelessWidget {
  final String title;
  final String? muscleGroup;
  final String? difficulty;
  final File? imageFile;
  final String? assetImage;

  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const ExerciseCard({
    super.key,
    required this.title,
    this.muscleGroup,
    this.difficulty,
    this.imageFile,
    this.assetImage,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: Padding(
        padding: const EdgeInsets.only(top: 9.0),
        child: Container(
          width: double.infinity,
          height: 65.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 3, color: Color(0xFF445E75)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Stack(
            children: [
              // =========================================================
              // EXERCISE IMAGE
              // =========================================================
              Positioned(
                left: 1.w,
                top: 1.h,
                bottom: 1.h,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                  child: SizedBox(
                    width: 95.87.w,
                    height: 65.09.h,
                    child: imageFile != null
                        ? Image.file(imageFile!, fit: BoxFit.cover)
                        : assetImage != null
                        ? Image.asset(assetImage!, fit: BoxFit.cover)
                        : Container(
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.fitness_center,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                  ),
                ),
              ),

              // =========================================================
              // TITLE
              // =========================================================
              Positioned(
                left: 108.w,
                top: 10.h,
                right: 65.w,
                child: Text(
                  title.isEmpty ? 'Exercise Name' : title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // =========================================================
              // MUSCLE GROUP + DIFFICULTY
              // =========================================================
              Positioned(
                left: 108.w,
                top: 38.h,
                right: 30.w,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        'Muscle group : ${muscleGroup ?? "Not set"}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: Text(
                        'Difficulty : ${difficulty ?? "Not set"}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 9,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // =========================================================
              // DELETE
              // =========================================================
              if (onDelete != null)
                Positioned(
                  right: 10.w,
                  top: 20.h,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: SizedBox(
                      width: 16.w,
                      height: 16.h,
                      child: const ImageIcon(
                        AssetImage('assets/images/Icons/delete.png'),
                        size: 14,
                        color: Color.fromARGB(255, 42, 37, 110),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
