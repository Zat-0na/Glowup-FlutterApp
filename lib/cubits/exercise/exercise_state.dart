import '../../models/grid_exercise.dart';

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseSuccess extends ExerciseState {
  final List<GridExercise> exercises;

  ExerciseSuccess(this.exercises);
}

class ExerciseFailure extends ExerciseState {
  final String errorMessage;

  ExerciseFailure(this.errorMessage);
}

