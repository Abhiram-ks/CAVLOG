import 'dart:developer';
import 'package:barber_pannel/cavlog/app/domain/usecases/delete_oldslots_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'slot_delete_privious_state.dart';

class SlotDeletePriviousCubit extends Cubit<SlotDeletePriviousState> {
  SlotDeletePriviousCubit() : super(SlotDeletePriviousInitial());

  Future<void> deleteOldSlots() async {
    log('the delete cubit was workig');
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? barberUid = prefs.getString('barberUid');

      if (barberUid != null) {
        final now = DateTime.now();
        final todayDate = DateFormat('dd-MM-yyyy').format(now);

        final String barberKey = 'deleted_${barberUid}_$todayDate';

        if (prefs.getBool(barberKey) == true) {
          return;
        }

        final deleteOldSlotsService = DeleteOldSlotsService();
        await deleteOldSlotsService.deleteOldSlotsWithIsolate(barberUid);

      await prefs.setBool(barberKey, true);
    }
    } catch (e) {
      log('delete errorr occured due to :$e');
      return;
    }
  }
}
