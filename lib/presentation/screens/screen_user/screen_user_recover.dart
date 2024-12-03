import 'package:flutter/material.dart';

class RecoverPassPageScreen extends StatefulWidget {
  const RecoverPassPageScreen({super.key});

  @override
  State<RecoverPassPageScreen> createState() => _RecoverPassPageScreenState();
}

class _RecoverPassPageScreenState extends State<RecoverPassPageScreen> {
  final formKey = GlobalKey<FormState>();
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
          '',
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF08cfe2), Color(0xFF04abce)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        20), // Ajusta el valor para redondear más o menos las esquinas
                    child: Image.asset(
                      'image/SleepWell.png',
                      height: 150,
                      width: 150,
                      fit: BoxFit
                          .cover, // Esto asegura que la imagen cubra completamente el espacio
                    ),
                  )),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Cambiar Contraseña',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Campo de correo
                      TextFormField(
                        controller: userEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa un correo válido';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Correo',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de nueva contraseña
                      TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingresa una contraseña válida';
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Nueva Contraseña',
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Confirmar nueva contraseña
                      TextFormField(
                        controller: confirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirma la contraseña';
                          }
                          if (value != password.text) {
                            return 'Las contraseñas no coinciden';
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Confirmar Contraseña',
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botón de cambio de contraseña
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            // Aquí se agrega la lógica para recuperar la contraseña
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Contraseña cambiada con éxito')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 4, 162, 193),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Cambiar Contraseña',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
