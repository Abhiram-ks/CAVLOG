abstract class UpdateSlotRepository {
  Future<bool> updateSlotAvailability({
    required String shopId,
    required String docId,
    required String subDocId,
    required bool status,
  });

  Future<bool> deleteSlotsFunction({
    required String shopId,
    required String docId,
    required String subDocId,
  });
}
