import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/providers/user_providers/user_account_provider.dart';

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
  bool _isHovering = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Image.asset(
                  'image/SleepWell.png', 
                  height: 100,
                  width: 100,
                ),
              ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0), 
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      TextFormField(
                        controller: userName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su nombre de usuario';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: const Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su correo electrónico';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.alternate_email),
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
                            return 'Ingrese una contraseña';
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
                              context.read<UserAccountProvider>().createUser(
                                  userName.text,
                                  email.text,
                                  password.text,
                                  context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isHovering
                                ? const Color.fromARGB(255, 5, 191, 228) 
                                : const Color.fromARGB(255, 4, 162, 193),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Create Account',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Enlace para iniciar sesión
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/log_in');
                            },
                            child: const Text(
                              'Login',
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
