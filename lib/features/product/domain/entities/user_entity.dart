import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
  });

  // ✅ تحويل Firebase User إلى UserModel
  factory UserModel.fromFirebase(User? user) {
    return UserModel(
      uid: user?.uid ?? '',
      name: user?.displayName ?? 'No Name',
      email: user?.email ?? 'No Email',
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [uid, name, email];
}
