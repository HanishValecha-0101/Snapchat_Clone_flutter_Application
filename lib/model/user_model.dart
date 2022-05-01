

import 'package:firebase_auth/firebase_auth.dart';

class UserModel{

  String name;
  String uid;
  String email;

  UserModel({this.uid, this.email, this.name});

  

  //receiving from server
  factory UserModel.fromMap(map){

    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}