import 'package:cloud_firestore/cloud_firestore.dart';

class SlotModel {
  final String docId;
  final String subDocId;
  final String shopId;
  final String time;
  final String date;
  final bool booked;
  final bool available;
  final DateTime dateTime;
  final Duration duration;
  


  SlotModel({
    required this.docId,
    required this.subDocId,
    required this.shopId,
    required this.time,
    required this.date,
    required this.booked,
    required this.available,
    required this.dateTime,
    required this.duration,
  });


  Map<String, dynamic> toMap() {
    return {
      'docId': docId, 
      'subdocId': subDocId,
      'shopId': shopId,
      'time': time,
      'date': date,
      'booked': booked,
      'available': available,
      'dateTime': Timestamp.fromDate(dateTime),
      'duration': duration.inMinutes,
    };
  }

  factory SlotModel.fromMap( Map<String, dynamic> map) {
   return SlotModel(
      docId: map['docId'] ?? '',
      subDocId: map['subdocId'] ?? '',
      shopId: map['shopId'] ?? '',
      time: map['time'] ?? '',
      date: map['date'] ?? '',
      booked: map['booked'] ?? false,
      available: map['available'] ?? true,
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      duration: Duration(minutes: map['duration'] ?? 0)
  );
  }
}