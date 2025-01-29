import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/components/app_button.dart';
import 'package:buddy_app/features/auth/components/app_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "BUDDY APP",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      fontFamily: AppTextStyles.arialRoundedMTBold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "WELCOME",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: AppTextStyles.arialRoundedMTBold),
                ),
                const SizedBox(
                  height: 60,
                ),
                AppTextField(
                  fieldType: 'Username',
                    controller: emailController,
                    hintText: 'JohnDoe@gmail.com',
                    obscureText: false),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  fieldType: 'Password',
                    controller: passwordController,
                    hintText: '***************',
                    obscureText: true),
                const SizedBox(
                  height: 25,
                ),
                AppButton(
                  onTap: () {},
                  text: 'Login',
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
