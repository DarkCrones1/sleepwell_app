import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/providers/user_providers/user_login_provider.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  final userNameOrEmail = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _isHovering = false; // Variable para el hover

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo degradado azul
          Container(
            height: MediaQuery.of(context).size.height * 0.6, // Más de la mitad
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
                padding: const EdgeInsets.only(top: 40.0), // Ajuste del logo
                child: Image.asset(
                  'image/SleepWell.png', // Ruta del logo
                  height: 100,
                  width: 100,
                ),
              ),
            ),
          ),
          // Centrar la tarjeta blanca
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0), // Más largo
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Campo de usuario
                      TextFormField(
                        controller: userNameOrEmail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su usuario o correo';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username / Email',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de contraseña
                      TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su contraseña';
                          }
                          return null;
                        },
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
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
                      const SizedBox(height: 15),
                      // Olvidó su contraseña
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/recover_pass');
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(color: Color(0xFF04abce)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Botón de inicio de sesión con efecto hover
                      MouseRegion(
                        onEnter: (_) {
                          setState(() {
                            _isHovering = true;
                          });
                        },
                        onExit: (_) {
                          setState(() {
                            _isHovering = false;
                          });
                        },
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              context.read<UserLoginProvider>().loginUser(
                                    userNameOrEmail.text,
                                    password.text,
                                    context,
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isHovering
                                ? const Color.fromARGB(255, 5, 191, 228) // Color al hacer hover
                                : const Color.fromARGB(255, 4, 162, 193),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Registro
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/sign_up');
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Color(0xFF04abce)),
                            ),
                          ),
                        ],
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
