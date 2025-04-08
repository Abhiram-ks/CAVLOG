import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String userName;
  final String phoneNumber;
  final String address;
  final String email;
  final String image;
  final int age;
  final DateTime createdAt;
  final bool google;

  UserModel({
    required this.uid,
    required this.userName,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.image,
    required this.age,
    required this.createdAt,
    required this.google
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map){
    return UserModel(
      uid: uid, 
      userName: map['userName'] ?? '', 
      phoneNumber: map['phoneNumber'] ?? '', 
      address: map['address'] ?? '', 
      email: map['email'] ?? '', 
      image: map['image'] ?? '', 
      age: map['age'] ?? 0,
      google: map['google'] ?? false,
      createdAt: (map['createdAt'] as Timestamp).toDate());
  }

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'address': address,
      'email': email,
      'image': image,
      'age': age,
      'google': google,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}