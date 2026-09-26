import '../../models/exercise.dart';

abstract class WorkoutPlanState {}

class WorkoutPlanInitial extends WorkoutPlanState {}

class WorkoutPlanUpdated extends WorkoutPlanState {
  final List<Exercise> exercises;

  WorkoutPlanUpdated(this.exercises);
}

