abstract class AuthEvent {}

class ShowSignInEvent extends AuthEvent {}

class ShowSignUpEvent extends AuthEvent {}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  SignUpEvent(
      {required this.name, required this.email, required this.password});
}

class GoogleSignInEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
// part of 'auth_bloc.dart';

// abstract class AuthEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class SignUpState extends AuthEvent {
//   final String name;
//   final String email;
//   final String password;

//   SignUpState( {required this.name,required this.email, required this.password});
// }

// class SignInState extends AuthEvent {
//   final String email;
//   final String password;

//   SignInState({required this.email, required this.password});
// }

// class SignOutRequested extends AuthEvent {}
