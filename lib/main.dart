import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/config/theme.dart';
import 'package:sleepwell_app/presentation/screens/screen_navbar/screen_navbar.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_user_login.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_user_recover.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_user_signup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: const MaterialAppWidget(),
    );
  }
}

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const LoginPageScreen(),
      routes: {
        '/home': (context) => const ScreenNavbar(),
        '/log_in': (context) => const LoginPageScreen(),
        '/sign_up': (context) => const SignUpPageScreen(),
        '/recover_pass': (context) => const RecoverPassPageScreen(),
      },
    );
  }
}