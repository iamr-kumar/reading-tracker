import 'package:flutter/material.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/core/widgets/google_button.dart';
import 'package:reading_tracker/core/widgets/input_field.dart';
import 'package:reading_tracker/core/widgets/or_divider.dart';
import 'package:reading_tracker/theme/Pallete.dart';
import 'package:routemaster/routemaster.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailConrtoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailConrtoller.dispose();
    _passwordController.dispose();
  }

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Container(
          height: height * 0.95,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: height * 0.20),
                  const Text('Welcome Back!',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Pallete.primaryBlue)),
                  const Text(
                    'You have been missed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Pallete.textGrey),
                  ),
                  SizedBox(height: height * 0.04),
                  SizedBox(height: height * 0.025),
                  InputField(
                      icon: Icons.email,
                      textEditingController: _emailConrtoller,
                      isPassword: false,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Email'),
                  SizedBox(height: height * 0.025),
                  InputField(
                      icon: Icons.lock,
                      textEditingController: _passwordController,
                      isPassword: true,
                      textInputType: TextInputType.text,
                      hintText: 'Password'),
                  SizedBox(height: height * 0.025),
                  CustomButton(
                      text: 'Login', isLoading: _isLoading, onPressed: () {}),
                  SizedBox(height: height * 0.035),
                  const OrDivider(),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  const GoogleSigninButton(),
                  SizedBox(height: height * 0.08),
                  InkWell(
                    onTap: () {
                      Routemaster.of(context).push('/signup');
                    },
                    child: const Text('New here? Register now',
                        style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.underline,
                            color: Pallete.textGrey)),
                  )
                ],
              ),
            ),
          )),
    ));
  }
}
