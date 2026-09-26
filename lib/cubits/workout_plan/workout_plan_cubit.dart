import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/exercise.dart';
import 'workout_plan_state.dart';

class WorkoutPlanCubit extends Cubit<WorkoutPlanState> {
  final List<Exercise> _exercises = [];

  WorkoutPlanCubit() : super(WorkoutPlanInitial());

  List<Exercise> get exercises => List.unmodifiable(_exercises);

  void addExercise(Exercise exercise) {
    // Prevent duplicate exercises by title
    final alreadyExists = _exercises.any(
      (item) => item.title == exercise.title,
    );

    if (alreadyExists) {
      return;
    }

    _exercises.add(exercise);

    emit(
      WorkoutPlanUpdated(
        List.from(_exercises),
      ),
    );
  }

  void removeExercise(int index) {
    if (index < 0 || index >= _exercises.length) {
      return;
    }

    _exercises.removeAt(index);

    emit(
      WorkoutPlanUpdated(
        List.from(_exercises),
      ),
    );
  }

  void updateExercise(
    int index,
    Exercise updatedExercise,
  ) {
    if (index < 0 || index >= _exercises.length) {
      return;
    }

    _exercises[index] = updatedExercise;

    emit(
      WorkoutPlanUpdated(
        List.from(_exercises),
      ),
    );
  }

  void clearPlan() {
    _exercises.clear();

    emit(
      WorkoutPlanUpdated(
        List.from(_exercises),
      ),
    );
  }
}

