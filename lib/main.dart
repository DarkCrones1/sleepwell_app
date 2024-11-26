import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:sleepwell_app/config/theme.dart';
import 'package:sleepwell_app/presentation/screens/screen_navbar/screen_navbar.dart';
import 'package:sleepwell_app/presentation/screens/screen_permision/screen_permision_user.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_edit_profile.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_user_login.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_user_recover.dart';
import 'package:sleepwell_app/presentation/screens/screen_user/screen_user_signup.dart';
import 'package:sleepwell_app/providers/user_providers/user_account_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserAccountProvider(),
        )
      ],
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
      title: 'Sleep Well',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: 1).getTheme(),
      home: const LoginPageScreen(),
      routes: {
        '/home': (context) => const ScreenNavbar(),
        '/log_in': (context) => const LoginPageScreen(),
        '/sign_up': (context) => const SignUpPageScreen(),
        '/recover_pass': (context) => const RecoverPassPageScreen(),
        '/screen_permissions': (context) => const ScreenPermisionUser(),
        '/edit_profile': (context) => const EditProfilePage(),
      },
    );
  }
}