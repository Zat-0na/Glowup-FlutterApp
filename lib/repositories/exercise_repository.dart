import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/grid_exercise.dart';

class ExerciseRepository {
  final String jsonPath;

  ExerciseRepository({
    this.jsonPath = 'assets/data/exercises.json',
  });

  Future<List<GridExercise>> getExercises() async {
    final String jsonString = await rootBundle.loadString(jsonPath);

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .map(
          (item) => GridExercise.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }
}
