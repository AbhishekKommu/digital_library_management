import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const DigitalLibraryApp());
}

class DigitalLibraryApp extends StatelessWidget {
  const DigitalLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Library Management',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.darkTheme,

      home: const LoginScreen(),
    );
  }
}