import 'dart:io';

import 'exercise_set.dart';

class Exercise {
  final String title;
  final String? muscleGroup;
  final String? difficulty;
  final File? imageFile;
  final String? assetImage;
  final List<ExerciseSet> sets;

  Exercise({
    required this.title,
    this.muscleGroup,
    this.difficulty,
    this.imageFile,
    this.assetImage,
    required this.sets,
  });
}
