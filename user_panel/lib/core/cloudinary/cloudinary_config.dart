import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryConfig {
  static late String cloudName;
  static late String apiKey;
  static late String apiSecret;

  static void initialize() {
   cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
   apiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
   apiSecret = dotenv.env['CLOUDINARY_API_SECRET'] ?? '';

   if (cloudName.isEmpty || apiKey.isEmpty || apiSecret.isEmpty) {
      log("Cloudinary cloud name is not set in the .env file");
      throw Exception("Cloudinary cloud name is not set in the .env file");
   }
  }
}