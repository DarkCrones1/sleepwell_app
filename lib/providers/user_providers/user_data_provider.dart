import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sleepwell_app/Infrastructure/models/response/user_data_response.dart';
import 'package:sleepwell_app/providers/user_providers/user_login_provider.dart';
import 'package:http/http.dart' as http;

class UserDataProvider extends ChangeNotifier {
  final logger = Logger();

  UserDataResponseDto? _userData;
  bool isloading = true;
  UserDataResponseDto? get userData => _userData;

  Future<void> getUserData() async {
  try {
    final userDataToken = UserLoginProvider();
    final token = await userDataToken.getAuthToken();

    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('http://sleepwellproject.somee.com/api/UserData/Self'),
      headers: <String, String>{
        'accept': 'application/json',  // aseguramos que aceptamos JSON
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Asegúrate de que 'Data' esté presente en la respuesta
      if (data != null && data['Data'] != null) {
        // Extrae los datos desde 'Data' y mapéalos al modelo
        _userData = UserDataResponseDto.fromJson(data['Data']);
        isloading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load user data: Data field is null');
      }
    } else {
      throw Exception('Failed to load data, status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e("Error fetching user data: $e");
    isloading = false;
    notifyListeners();
    throw Exception('Error fetching user data');
  }
}

}
