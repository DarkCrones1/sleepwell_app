import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sleepwell_app/Infrastructure/models/response/user_commend_response.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell_app/providers/user_providers/user_login_provider.dart';

class UserCommendProvider extends ChangeNotifier {
  final logger = Logger();

  List<UserCommendResponseDto>? _userCommend;
  bool isLoading = true;
  List<UserCommendResponseDto>? get userCommend => _userCommend;

  Future<List<UserCommendResponseDto>> getUserCommend({int status = 1, int pageSize = 1}) async {
    try {
      final userDataToken = UserLoginProvider();
      final token = await userDataToken.getAuthToken();

      if (token == null) {
        throw Exception('Token is null');
      }

      final response = await http.get(
        Uri.parse(
            'https://sleepwellproject.somee.com/api/UserCommend?SleepQualityStatus=$status&RandomCommend=true&PageSize=$pageSize'),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      logger.d(
          'https://sleepwellproject.somee.com/api/UserCommend?SleepQualityStatus=$status&RandomCommend=true');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['Data'] != null) {
          final List<dynamic> commendList = data['Data'];

          final recommendations = commendList
              .map((commend) => UserCommendResponseDto.fromJson(commend))
              .toList();

          _userCommend = recommendations;
          isLoading = false;
          notifyListeners(); // Notifica a los consumidores del provider

          return recommendations; // Devuelve los datos procesados
        } else {
          throw Exception(
              'El campo "Data" es nulo o no existe en la respuesta');
        }
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Error al obtener datos de Recomendaciones: $e");
      isLoading = false;
      notifyListeners();
      rethrow; // Propaga el error si ocurre
    }
  }
}
