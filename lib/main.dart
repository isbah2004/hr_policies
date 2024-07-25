import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hr_policies/firebase_options.dart';
import 'package:hr_policies/provider/auth_provider.dart';
import 'package:hr_policies/splashscreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ObscureTextProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => LoginProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ResetProvider(),
      ),
    ],
    child: const MaterialApp(
      home: SplashScreen(),
    ),
  ));
}
