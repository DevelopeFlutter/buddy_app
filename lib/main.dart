import 'package:buddy_app/features/auth/login_page.dart';
import 'package:buddy_app/features/landing_page/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/auth/services/auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => PostProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Buddy App',
        home: LoginPage(),
      ),
    );
  }
}
