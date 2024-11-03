
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class SignUpPageScreen extends StatefulWidget {
  const SignUpPageScreen({super.key});

  @override
  State<SignUpPageScreen> createState() => _SignUpPageScreenState();
}

class _SignUpPageScreenState extends State<SignUpPageScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final userName = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registro de cuenta'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Image.asset(
                'image/mundoartesano.png',
                height: 250,
                width: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: userName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ingresa un nombre de usuario';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Nombre de Usuario',
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
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'example@gmail.com';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    filled: true,
                    labelText: 'Correo',
                    suffixIcon: Icon(Icons.alternate_email),
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
                      return 'Ingresa una contraseña';
                    }
                    return null;
                  },
                  obscureText: !_passwordVisible,
                  keyboardType: TextInputType.text,
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
              // OverflowBar(
              //   children: <Widget>[
              //     TextButton.icon(
              //         onPressed: () {
              //           if (formKey.currentState!.validate()) {
              //             context.read<UserAccountProvider>().create(
              //                 userName.text,
              //                 password.text,
              //                 email.text,
              //                 context);
              //           }
              //         },
              //         icon: const Icon(Icons.create),
              //         label: const Text('Crear cuenta')),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}