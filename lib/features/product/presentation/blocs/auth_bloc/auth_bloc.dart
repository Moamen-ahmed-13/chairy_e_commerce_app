import 'package:chairy_e_commerce_app/features/product/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<ShowSignInEvent>((event, emit) => emit(SignInState()));
    on<ShowSignUpEvent>((event, emit) => emit(SignUpState()));
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<GoogleSignInEvent>(_onGoogleSignIn);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.login(event.email, event.password);
      if (user.uid.isEmpty) {
        emit(AuthError("Invalid email or password."));
        return;
      }
      emit(AuthAuthenticated(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getFirebaseErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError("Unknown error: ${e.toString()}"));
    }
  }
  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.register(event.email, event.password);
      if (user.uid.isEmpty) {
        emit(AuthError("Registration failed, please try again"));
        return;
      }


      emit(AuthAuthenticated(user: user));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getFirebaseErrorMessage(e.code)));
    } catch (e) {
      emit(AuthError("Unknown error: ${e.toString()}"));
    }
  }
   String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return "User not found";
      case 'wrong-password':
        return "Wrong password";
      case 'invalid-email':
        return "Invalid email";
      case 'user-disabled':
        return "User disabled";
      case 'email-already-in-use':
        return "Email already in use";
      case 'weak-password':
        return "Weak password";
      default:
        return "Unknown error";
    }
  }
  Future<void> _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.googleSignIn();
      emit(AuthAuthenticated(user: user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await authRepository.logout();
    emit(AuthInitial());
  }
}
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../../domain/repositories/auth_repository.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository _authRepository;

//   AuthBloc({required AuthRepository authRepository})
//       : _authRepository = authRepository,
//         super(AuthInitial()) {
//     on<SignUpRequested>(_onSignUp);
//     on<SignInRequested>(_onSignIn);
//     on<SignOutRequested>(_onSignOut);
//   }

//   void _onSignUp(SignUpRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.signUp(
//         email: event.email,
//         password: event.password,
//       );
//       if (user != null) {
//         emit(AuthSuccess(user: user));
//       } else {
//         emit(AuthFailure(error: "Sign up failed"));
//       }
//     } catch (e) {
//       emit(AuthFailure(error: e.toString()));
//     }
//   }

//   void _onSignIn(SignInRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.signIn(
//         email: event.email,
//         password: event.password,
//       );
//       if (user != null) {
//         emit(AuthSuccess(user: user));
//       } else {
//         emit(AuthFailure(error: "Sign in failed"));
//       }
//     } catch (e) {
//       emit(AuthFailure(error: e.toString()));
//     }
//   }

//   void _onSignOut(SignOutRequested event, Emitter<AuthState> emit) async {
//     emit(AuthLoading());
//     try {
//       await _authRepository.signOut();
//       emit(AuthInitial());
//     } catch (e) {
//       emit(AuthFailure(error: e.toString()));
//     }
//   }
// }
