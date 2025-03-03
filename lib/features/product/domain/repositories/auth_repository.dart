import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
  Future<void> logout();
  Future<UserModel> googleSignIn();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRepositoryImpl(this.remoteDataSource);

  @override
Future<UserModel> login(String email, String password) async {
  try {
    UserModel user = await remoteDataSource.login(email, password); // ✅ استخدم UserModel
    return user;
  } on FirebaseAuthException catch (e) {
    throw FirebaseAuthException(code: e.code, message: e.message);
  }
}

  @override
  Future<UserModel> register(String email, String password) {
    return remoteDataSource.register(email, password);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  Future<UserModel> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception("Google Sign-In Canceled");
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    return UserModel.fromFirebase(userCredential.user);
  }
}
// import 'package:firebase_auth/firebase_auth.dart';

// class AuthRepository {
//   final FirebaseAuth _firebaseAuth;

//   AuthRepository({FirebaseAuth? firebaseAuth})
//       : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

//   // تسجيل مستخدم جديد
//   Future<User?> signUp({required String email, required String password}) async {
//     try {
//        await _firebaseAuth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       ).then((value) {
//         return value.user ?? null;
//       });
      
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   // تسجيل الدخول
//   Future<User?> signIn({required String email, required String password}) async {
//     try {
//       UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return userCredential.user;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }

//   // تسجيل الخروج
//   Future<void> signOut() async {
//     await _firebaseAuth.signOut();
//   }
// }
