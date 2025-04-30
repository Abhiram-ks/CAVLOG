import 'package:cloud_firestore/cloud_firestore.dart';

class DateModel {
  final String id;
  final String date;

  DateModel({
    required this.id,
    required this.date,
  });

  factory DateModel.fromDocument(DocumentSnapshot doc) {
    return DateModel(
      id: doc.id, 
      date: doc.id,
    );
  }
}

