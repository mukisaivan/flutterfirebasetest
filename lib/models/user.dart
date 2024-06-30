// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String uid;
  final String email;
  final String photoUrl;

  UserModel({
    required this.username,
    required this.uid,
    required this.email,
    required this.photoUrl,
  });

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      email: snapshot["email"],
      uid: snapshot["uid"],
      photoUrl: snapshot["photoUrl"],
      username: snapshot["username"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"] as String,
      uid: map["uid"] as String,
      photoUrl: map["photoUrl"] as String,
      username: map["username"] as String,
    );
  }
}
