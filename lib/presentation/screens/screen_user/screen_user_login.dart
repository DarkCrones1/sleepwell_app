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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Inicio de sesión',
        ),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Stack(
            children: [
              // Fondo degradado azul
              Container(
                height:
                    MediaQuery.of(context).size.height * 0.6, // Más de la mitad
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF08cfe2), Color(0xFF04abce)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              20), // Ajusta el valor para redondear más o menos las esquinas
                          child: Image.asset(
                            'image/SleepWell.png',
                            height: 150,
                            width: 150,
                            fit: BoxFit
                                .cover, // Esto asegura que la imagen cubra completamente el espacio
                          ),
                        )
                      ],
                    )
                  ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 40.0), // Más largo
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            'Inicio de Sesión',
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
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              filled: true,
                              labelText: 'Nombre Usuario / Email',
                              suffixIcon: Icon(Icons.account_circle),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Campo de contraseña
                          TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ingrese una contraseña';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Contraseña',
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
                          const SizedBox(height: 15),
                          // Olvidó su contraseña
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/recover_pass');
                                    },
                                    child: const Text(
                                      'Olvidaste tu contraseña?',
                                      style:
                                          TextStyle(color: Color(0xFF04abce)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                                    ? const Color.fromARGB(255, 5, 191,
                                        228) // Color al hacer hover
                                    : const Color.fromARGB(255, 4, 162, 193),
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              child: const Text(
                                'Iniciar Sesión',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                          OverflowBar(children: <Widget>[
                            const Text("¿No tienes cuenta? "),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/sign_up');
                              },
                              child: const Text(
                                'Registrar',
                                style: TextStyle(color: Color(0xFF04abce)),
                              ),
                            ),
                          ]),
                          // Registro
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
