import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_panel/app/domain/usecases/rating_service_usecase.dart';
import '../models/barber_model.dart' show BarberModel;

abstract class FetchBarberRepository {
  Stream<List<BarberModel>> streamAllBarbers();
  Stream<BarberModel> streamBarber(String barberId);
 
}

class FetchBarberRepositoryImpl implements FetchBarberRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RatingServiceUsecase _ratingService = RatingServiceUsecase();


  @override
  Stream<List<BarberModel>> streamAllBarbers() {
    return _firestore
        .collection('barbers')
        .orderBy('ventureName')
        .snapshots()
        .asyncMap((querySnapshot) async {
      final barbers = await Future.wait(querySnapshot.docs.map((doc) async {
        try {
          final rating = await _ratingService.fetchAverageRating(doc.id);
          return BarberModel.fromMap(doc.id, rating, doc.data());
        } catch (e) {
          log('Error parsing barber: $e');
          return null;
        }
      }));
      return barbers.whereType<BarberModel>().toList();
    }).handleError((e) {
      log('Error fetching all barbers: $e');
    });
  }

  @override
  Stream<BarberModel> streamBarber(String barberId) {
    return _firestore
        .collection('barbers')
        .doc(barberId)
        .snapshots()
        .asyncMap((snapshot) async {
      if (snapshot.exists) {
        try {
          final rating = await _ratingService.fetchAverageRating(barberId);
          return BarberModel.fromMap(snapshot.id,rating,snapshot.data() as Map<String, dynamic>);
        } catch (e) {
          log('Error with rating: $e');
          rethrow;
        }
      } else {
        throw Exception('Barber not found');
      }
    }).handleError((error) {
      log('Error fetching barber data: $error');
    });
  }
}