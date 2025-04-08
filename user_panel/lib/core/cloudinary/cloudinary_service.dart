import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:user_panel/core/cloudinary/cloudinary_config.dart';


class CloudinaryService {
  Future<String?> uploadImage(File imageFile) async {
    try {
      final url = Uri.parse("https://api.cloudinary.com/v1_1/${CloudinaryConfig.cloudName}/image/upload");

      final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = 'abhiram_ks'
      ..fields['folder'] = 'cavlog/banner'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();
      if(response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseBody);
        return jsonResponse['secure_url'] as String?;
      }else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}