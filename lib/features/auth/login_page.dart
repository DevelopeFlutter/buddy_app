import 'package:buddy_app/constants/text_styles.dart';
import 'package:buddy_app/features/auth/components/app_button.dart';
import 'package:buddy_app/features/auth/components/app_textfield.dart';
import 'package:buddy_app/features/auth/services/auth_provider.dart';
import 'package:buddy_app/features/landing_page/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).loadUsers();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    await Provider.of<AuthProvider>(context, listen: false)
        .login(email, password);

    if (Provider.of<AuthProvider>(context, listen: false).loggeInUsers !=
        null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Successful')));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Provider.of<AuthProvider>(context).loginLoading
                ? const CircularProgressIndicator()
                : Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "BUDDY APP",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                              fontFamily: AppTextStyles.arialRoundedMTBold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "WELCOME",
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              fontFamily: AppTextStyles.arialRoundedMTBold),
                        ),
                        const SizedBox(height: 60),
                        AppTextField(
                          fieldType: 'Username',
                          controller: emailController,
                          hintText: 'JohnDoe@gmail.com',
                          obscureText: false,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter Email'
                              : null,
                        ),
                        AppTextField(
                          fieldType: 'Password',
                          controller: passwordController,
                          hintText: '***************',
                          obscureText: true,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Enter Password'
                              : null,
                        ),
                        const SizedBox(height: 25),
                        AppButton(
                          height: 42,
                          width: 180,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: AppTextStyles.arialUniCodeMs,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                          onTap: _login,
                          text: 'Login',
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
