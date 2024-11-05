// import 'package:mundoartesano/providers/user_providers/login_user_account_provider.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

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
          child: ListView(
            children: <Widget>[
              Column(
                children: [
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
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: userNameOrEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingrese un correo';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
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
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('¿Olvidaste tu contraseña?'),
                      TextButton(
                        child: const Text('presiona aqui'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/recover_pass');
                        },
                      ),
                    ],
                  ),
                  FilledButton(
                    child: const Text('Entrar'),
                    onPressed: () async {
                      // if (formKey.currentState!.validate()) {
                      //   context.read<LoginUserProvider>().loginUser(
                      //       userNameOrEmail.text, password.text, context);
                      // }
                      Navigator.restorablePushNamedAndRemoveUntil(
                          context, '/home', (route) => false);
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              OverflowBar(
                children: <Widget>[
                  TextButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                      label: const Text('Regístrate')),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
