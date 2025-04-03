import 'package:geocoding/geocoding.dart';

class AddressFormatter {
  static String formatAddress(Placemark place) {
    String address = "";

    if (place.street != null && place.street!.isNotEmpty) {
      address = place.street!;
    } else if (place.name != null &&
        place.name!.isNotEmpty &&
        !place.name!.contains('+')) {
      address = place.name!;
    }

    if (place.subLocality != null && place.subLocality!.isNotEmpty) {
      address +=
          address.isEmpty ? place.subLocality! : ", ${place.subLocality!}";
    }
    if (place.locality != null && place.locality!.isNotEmpty) {
      address += address.isEmpty ? place.locality! : ", ${place.locality}";
    }
    if (place.administrativeArea != null &&
        place.administrativeArea!.isNotEmpty) {
      address += address.isEmpty
          ? place.administrativeArea!
          : ", ${place.administrativeArea}";
    }
    if (place.country != null && place.country!.isNotEmpty) {
      address += address.isEmpty ? place.country! : ", ${place.country}";
    }

    return address;
  }
}
