import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:app1/models/fruit.dart';
import 'package:app1/config/constants.dart';

class ApiService {
  Future<List<Fruit>> getFruits() async {
    try {
      final response = await http
          .get(
            Uri.parse(
                '${AppConstants.apiURL}${AppConstants.getFruitsEndpoint}'),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Fruit.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load fruits: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  Future<void> createFruit(String name, bool seedless, File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppConstants.apiURL}${AppConstants.newFruitEndpoint}'),
      );

      request.fields['name'] = name;
      request.fields['seedless'] = seedless.toString();

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      var streamedResponse =
          await request.send().timeout(const Duration(seconds: 15));
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode != 200) {
        Map<String, dynamic> errorData = json.decode(response.body);
        throw Exception(errorData['detail'] ?? 'Failed to create fruit');
      }
    } catch (e) {
      throw Exception('Error creating fruit.');
    }
  }
}
