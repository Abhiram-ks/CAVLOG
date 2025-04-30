import 'package:intl/intl.dart';

bool isSlotTimeExceeded(String dateStr, String timeStr) {
  try {
    final cleanedTime = timeStr.replaceAll('\u202F', ' ');
    final fullDateTime = "$dateStr $cleanedTime";

    final format = DateFormat("dd-MM-yyyy h:mm a");
    final slotDateTime = format.parse(fullDateTime);

    final now = DateTime.now();
    return slotDateTime.isBefore(now);
  } catch (e) {
    return false;
  }
}
