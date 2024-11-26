import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
import 'package:sleepwell_app/Infrastructure/models/request/login_request.dart';
import 'package:sleepwell_app/Infrastructure/models/response/user_account_response.dart';  

class UserLoginProvider extends ChangeNotifier {
  final logger = Logger();
  final storage = const FlutterSecureStorage();

  List<UserAccountResponseDto>? _users;
  bool isloading = true;
  List<UserAccountResponseDto>? get users => _users;

  Future loginUser(String userNameOrEmail, String password, BuildContext context) async {
    final user = LoginRequestDto(userNameOrEmail: userNameOrEmail, password: password);

    try {
      final response = await http.post(
        Uri.parse('http://sleepwellproject.somee.com/api/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body)['token'];
        await storage.write(key: 'token', value: json);

        final token = await getAuthToken();
        logger.d('token almacenado es: $token');

        // Usamos Future.delayed para asegurar que el context esté disponible
        Future.delayed(Duration.zero, () {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Bienvenid@ ${user.userNameOrEmail}"))
            );
            Navigator.restorablePushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        });
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Verifique que su Nombre de usuario / Email o contraseña sean válidos"))
          );
        }
      }
    } catch (e) {
      logger.e('Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al conectar con el servidor"))
        );
      }
    }
  }

  Future<String?> getAuthToken() async {
    return storage.read(key: 'token');
  }

  Future clearAuthToken() async {
    return storage.delete(key: 'token');
  }
}
