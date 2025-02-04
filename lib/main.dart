import 'package:buddy_app/features/auth/login_page.dart';
import 'package:buddy_app/features/detail_page/post_detail_screen.dart';
import 'package:buddy_app/features/landing_page/landing_page.dart';
import 'package:buddy_app/features/new_post/new_post_page.dart';
import 'package:buddy_app/features/profile/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Buddy App',
      home: 
      LoginPage()
      // PostDetailScreen(),
    
      // LandingPage(),
     
    );
  }
}

