import 'package:cloud_firestore/cloud_firestore.dart';

class BarberModel {
  final String uid;
  final String barberName;
  final String ventureName;
  final String phoneNumber;
  final String address;
  final String email;
  final bool isVerified;
  final bool isblok;
  String? image;
  int? age;
  final Timestamp? createdAt;

  BarberModel({
    required this.uid,
    required this.barberName,
    required this.ventureName,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.isVerified,
    required this.isblok,
    this.image,
    this.age,
    this.createdAt,
  });

  factory BarberModel.fromMap(String uid, Map<String, dynamic> map){
    return BarberModel(
      uid: uid,
      barberName: map['barberName'] ?? '',
      ventureName: map['ventureName'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
      email: map['email'] ?? '', 
      isVerified: map['isVerified'] ?? false,
      isblok: map['isBlok'] ?? false,
      image: map['image'],
      age: map['age'],
      createdAt: map['createdAt'], 
    );
  }
}