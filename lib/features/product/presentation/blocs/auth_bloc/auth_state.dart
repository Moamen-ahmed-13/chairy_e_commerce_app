import 'package:equatable/equatable.dart';
import '../../../domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class SignInState extends AuthState {}

class SignUpState extends AuthState {}

class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
// part of 'auth_bloc.dart';

// abstract class AuthState extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class AuthInitial extends AuthState {}

// class AuthLoading extends AuthState {}

// class AuthSuccess extends AuthState {
//   final User user;
//   AuthSuccess({required this.user});
// }

// class AuthFailure extends AuthState {
//   final String error;
//   AuthFailure({required this.error});
// }
