import 'package:cloud_firestore/cloud_firestore.dart';

class Barber {
  final String barberName;
  final String ventureName;
  final String phoneNumber;
  final String address;
  final String email;
  final bool isVerified;
  String? image;
  int? age;
  final bool isBlocked;
  final String uid;
  final DateTime? createdAt;

  Barber({
    required this.barberName,
    required this.ventureName,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.isVerified,
    this.image,
    this.age,
    required this.isBlocked,
    required this.uid,
    required this.createdAt,
  });


  factory Barber.fromFirestore(Map<String, dynamic> data) {
    return Barber(
      barberName:  data['barberName'] ?? '',
      ventureName: data['ventureName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      address: data['address'] ?? '',
      email: data['email'] ?? '',
      isVerified: data['isVerified'] ?? false,
      image: data['image'],
      age: data['age'],
      isBlocked: data['isBlok'] ?? false,
      uid: data['Uid'] ?? '',
      createdAt:(data['createdAt'] as Timestamp?)?.toDate(),
      );
  }
}