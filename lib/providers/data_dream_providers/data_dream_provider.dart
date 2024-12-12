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

  Future<void> getDataDream({int pageSize = 7}) async {
    isLoading = true; // Iniciamos el estado de carga
    notifyListeners();

    try {
      // Obtención del token
      final userDataToken = UserLoginProvider();
      final token = await userDataToken.getAuthToken();
      if (token == null || token.isEmpty) {
        throw Exception('Token no válido o nulo');
      }

      // Llamada a la API
      final response = await http.get(
        Uri.parse(
            'https://sleepwellproject.somee.com/api/DataDream/Self?PageSize=$pageSize'),
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      // Verificación del estado de la respuesta
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        logger.d('Response body: ${response.body}');

        if (data.containsKey('Data') && data['Data'] is List) {
          // Parseo del JSON
          final List<dynamic> dataDreamList = data['Data'];
          _dataDream = dataDreamList
              .map((dream) => DataDreamResponseDto.fromJson(dream))
              .toList();
        } else {
          throw Exception(
              'El campo "Data" es inválido o no existe en la respuesta');
        }
      } else {
        throw Exception(
            'Error al obtener datos: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      logger.e("Error al obtener datos de DataDream: $e");
      _dataDream = null; // En caso de error, aseguramos que la lista esté vacía
    } finally {
      isLoading = false; // Finalizamos el estado de carga
      notifyListeners(); // Notificamos el cambio de estado
    }
  }
}
