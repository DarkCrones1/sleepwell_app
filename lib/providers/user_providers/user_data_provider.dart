import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sleepwell_app/Infrastructure/models/request/update/user_data_update.dart';
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
      Uri.parse('https://sleepwellproject.somee.com/api/UserData/Self'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Valida que el campo `Data` no sea nulo
      if (data != null && data['Data'] != null) {
        _userData = UserDataResponseDto.fromJson(data['Data']);
        isloading = false;
        notifyListeners();
      } else {
        throw Exception('Data field is null or missing in API response');
      }
    } else {
      throw Exception(
          'Failed to load data, status code: ${response.statusCode}');
    }
  } catch (e) {
    logger.e("Error fetching user data: $e");
    isloading = false;
    notifyListeners();
    throw Exception('Error fetching user data');
  }
}

  Future updateData(
      String firstName,
      String middleName,
      String lastName,
      String phone,
      String cellPhone,
      int gender,
      DateTime birthDate,
      BuildContext context) async {
    final userDataToken = UserLoginProvider();
    final token = await userDataToken.getAuthToken();

    final user = UserDataUpdateDto(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phone: phone,
        cellPhone: cellPhone,
        gender: gender,
        birthDate: birthDate);

    logger.d(token);
    logger.d(user);

    final response = await http.put(
      Uri.parse('https://sleepwellproject.somee.com/api/UserData'),
      headers: <String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Perfil Actualizado')));
        Navigator.pop(context);
      }
    } else {
      logger.e('Error: {Rellene los campos faltantes}');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Rellene todos los campos"),
              actions: [
                TextButton(
                  child: const Text("Cerrar"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
}
