class ProfileState {
  final String name;

  const ProfileState({this.name = 'Zein'});

  ProfileState copyWith({String? name}) {
    return ProfileState(name: name ?? this.name);
  }
}
