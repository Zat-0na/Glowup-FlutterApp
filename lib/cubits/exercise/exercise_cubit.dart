
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/grid_exercise.dart';
import '../../repositories/exercise_repository.dart';
import 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  final ExerciseRepository exerciseRepository;

  ExerciseCubit(this.exerciseRepository)
      : super(ExerciseInitial());

  Future<void> getExercises() async {
    emit(ExerciseLoading());

    try {
      final List<GridExercise> exercises =
          await exerciseRepository.getExercises();

      emit(ExerciseSuccess(exercises));
    } catch (e) {
      emit(
        ExerciseFailure(
          e.toString(),
        ),
      );
    }
  }
}

