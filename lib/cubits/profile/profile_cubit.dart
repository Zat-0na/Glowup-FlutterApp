import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void updateName(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return;
    }

    emit(state.copyWith(name: trimmedName));
  }
}
