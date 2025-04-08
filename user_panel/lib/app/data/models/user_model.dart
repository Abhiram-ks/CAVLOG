import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final bool google;
  final DateTime createdAt;
  final String userName;
  final String image;
  final String phoneNumber;
  final String address;
  final int age;

  UserModel({
    required this.uid,
    required this.email,
    required this.google,
    required this.createdAt,
    required this.userName,
    required this.image,
    required this.phoneNumber,
    required this.address,
    required this.age
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map){
    return UserModel(
      uid: uid, 
      email: map['email'] ?? '', 
      google: map['google'] ?? false, 
      createdAt: (map['createdAt'] as Timestamp).toDate(), 
      userName: map['userName'] ?? '', 
      image: map['image'] ?? '', 
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '', 
      age: map['age'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'uid' : uid,
      'email': email,
      'google':google,
      'createdAt':createdAt,
      'userName':userName,
      'image': image,
      'phoneNumber': phoneNumber,
      'address': address,
      'age': age
    };
  }
}