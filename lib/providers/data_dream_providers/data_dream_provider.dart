import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sleepwell_app/Infrastructure/models/response/data_dream_response.dart';
import 'package:sleepwell_app/providers/user_providers/user_login_provider.dart';
import 'package:http/http.dart' as http;

class DataDreamProvider extends ChangeNotifier {
  final logger = Logger();

  List<DataDreamResponseDto>? _dataDream;
  bool isLoading = true;
  List<DataDreamResponseDto>? get dataDream => _dataDream;

  Future<void> getDataDream({int pageSize = 25}) async {
    // Aquí añadimos el parámetro pageSize
    try {
      final userDataToken = UserLoginProvider();
      final token = await userDataToken.getAuthToken();

      if (token == null) {
        throw Exception('Token is null');
      }

      final response = await http.get(
        Uri.parse(
            'https://sleepwellproject.somee.com/api/DataDream/Self?PageSize=$pageSize'), // Usamos el pageSize dinámico
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Verifica si el campo 'Data' existe en la respuesta
        if (data['Data'] != null) {
          // Mapeo de la respuesta JSON a una lista de DataDreamResponseDto
          final List<dynamic> dataDreamList = data['Data'];

          _dataDream = dataDreamList
              .map((dream) => DataDreamResponseDto.fromJson(dream))
              .toList();

          isLoading = false;
          notifyListeners(); // Notifica que la carga ha terminado
        } else {
          throw Exception(
              'El campo "Data" es nulo o no existe en la respuesta');
        }
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Error al obtener datos de DataDream");
      isLoading = false; // Si ocurre un error, se detiene el loading
      notifyListeners(); // Notifica que el loading ha terminado
    }
  }
}
