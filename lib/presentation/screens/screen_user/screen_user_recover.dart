import 'package:flutter/material.dart';

class RecoverPassPageScreen extends StatefulWidget {
  const RecoverPassPageScreen({super.key});

  @override
  State<RecoverPassPageScreen> createState() => _RecoverPassPageScreenState();
}

class _RecoverPassPageScreenState extends State<RecoverPassPageScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final userEmail = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Cambiar Contraseña',
          ),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: ListView(
              children: <Widget>[
              Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20), // Ajusta el valor para redondear más o menos las esquinas
                    child: Image.asset(
                      'image/SleepWell.png',
                      height: 250,
                      width: 250,
                      fit: BoxFit
                          .cover, // Esto asegura que la imagen cubra completamente el espacio
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: userEmail,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa un correo válido';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        filled: true,
                        labelText: 'Correo',
                        suffixIcon: Icon(Icons.account_circle),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa una contraseña valida';
                        }
                        return null;
                      },
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'contraseña',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingresa una contraseña valida';
                        }
                        return null;
                      },
                      obscureText: !_passwordVisible,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'confirmar contraseña',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
