import 'package:chairy_e_commerce_app/features/product/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth;

  AuthRemoteDataSourceImpl(this.auth);

  @override
  Future<UserModel> login(String email, String password) async {
    UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    
    return UserModel.fromFirebase(userCredential.user);
  }

  @override
Future<UserModel> register(String email, String password) async {
  try {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user == null) {
      throw FirebaseAuthException(code: "registration-failed", message: "Registration failed");
    }

    return UserModel.fromFirebase(userCredential.user);
  } on FirebaseAuthException catch (e) {
    throw FirebaseAuthException(code: e.code, message: e.message);
  } catch (e) {
    throw Exception("unknown error: ${e.toString()}");
  }
}

  @override
  Future<void> logout() async {
    await auth.signOut();
  }
}
