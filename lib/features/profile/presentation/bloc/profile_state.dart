import 'package:equatable/equatable.dart';
import 'package:pizza_app/shared/auth/models/user.dart';

class ProfileState extends Equatable {
  final User? user;
  final bool isUpdating;
  final String? errorKey;
  final String? successKey;

  const ProfileState({
    this.user,
    this.isUpdating = false,
    this.errorKey,
    this.successKey,
  });

  ProfileState copyWith({
    User? user,
    bool? isUpdating,
    String? errorKey,
    String? successKey,
    bool clearMessages = false,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isUpdating: isUpdating ?? this.isUpdating,
      errorKey: clearMessages ? null : (errorKey ?? this.errorKey),
      successKey: clearMessages ? null : (successKey ?? this.successKey),
    );
  }

  @override
  List<Object?> get props => [user, isUpdating, errorKey, successKey];
}
