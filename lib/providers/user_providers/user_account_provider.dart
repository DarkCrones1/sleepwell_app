import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sleepwell_app/Infrastructure/models/request/create/user_account_create.dart';
import 'package:sleepwell_app/Infrastructure/models/response/user_account_response.dart';

class UserAccountProvider extends ChangeNotifier {

  final logger = Logger();
  List<UserAccountResponseDto>? _users;
  bool isloading = true;
  List<UserAccountResponseDto>? get users => _users;

  Future getUsers() async {
    final response = await http
        .get(Uri.parse('https://kaabstore.somee.com/WebAPI_Kaab_Haak/Account'));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> data = json['data'];

      _users = data.map((user) => UserAccountResponseDto.fromJson(user)).toList();

      isloading = false;

      notifyListeners(); // Notificar cambios
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future createUser(String userName, String email, String password, BuildContext context) async {
    final user = UserAccountCreateDto(userName: userName ,email: email, password: password);

    final response = await http.post(
      Uri.parse('https://sleepwellproject.somee.com/api/UserAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      logger.d('User created: ${response.body}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuario Creado')),
        );
        Navigator.pop(context);
      }
    } else {
      logger.e('Error: {El correo o contraseña es incorrecta}');
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("Elija un correo válido"),
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

  void logout() {}
}
