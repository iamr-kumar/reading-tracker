// ignore_for_file: camel_case_extensions

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reading_tracker/core/widgets/custom_button.dart';
import 'package:reading_tracker/core/widgets/google_button.dart';
import 'package:reading_tracker/core/widgets/input_field.dart';
import 'package:reading_tracker/core/widgets/or_divider.dart';
import 'package:reading_tracker/features/auth/controllers/auth_controller.dart';

import 'package:reading_tracker/theme/app_styles.dart';
import 'package:reading_tracker/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailConrtoller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailConrtoller.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  String? _emailValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Invalid Email';
    }
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegExp.hasMatch(val)) {
      return 'Invalid Email';
    }
    return null;
  }

  String? _passwordValidator(String? val) {
    if (val == null || val.length < 8) {
      return 'Password is too small';
    }
    if (val != _confirmPasswordController.text) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  String? _passwordMatchValidator(String? val) {
    if (val != _passwordController.text) {
      return 'Passwords don\'t match';
    }
    return null;
  }

  void signUp() {
    ref.read(authControllerProvider.notifier).signUp(_nameController.text,
        _emailConrtoller.text, _passwordController.text, context);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: SafeArea(
          child: Container(
        height: height * 0.95,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.06),
              const Text('Welcome', style: AppStyles.headingOne),
              Text(
                'Let\'s get you started',
                style: AppStyles.subtext.copyWith(color: Pallete.textBlue),
              ),
              SizedBox(height: height * 0.05),
              Text('Sign Up',
                  style:
                      AppStyles.headingTwo.copyWith(color: Pallete.textBlue)),
              SizedBox(height: height * 0.02),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InputField(
                        textEditingController: _nameController,
                        isPassword: false,
                        textInputType: TextInputType.text,
                        hintText: 'Full Name',
                        icon: Icons.people,
                        validator: (val) {
                          if (val == null) {
                            return 'Name cannot be empty';
                          }
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      InputField(
                          validator: _emailValidator,
                          textEditingController: _emailConrtoller,
                          isPassword: false,
                          textInputType: TextInputType.emailAddress,
                          hintText: 'Email',
                          icon: Icons.email),
                      SizedBox(height: height * 0.02),
                      InputField(
                          textEditingController: _passwordController,
                          isPassword: true,
                          textInputType: TextInputType.text,
                          hintText: 'Choose Password',
                          validator: _passwordValidator,
                          icon: Icons.lock),
                      SizedBox(height: height * 0.02),
                      InputField(
                          textEditingController: _confirmPasswordController,
                          isPassword: true,
                          textInputType: TextInputType.text,
                          hintText: 'Confirm Password',
                          icon: Icons.lock,
                          validator: _passwordMatchValidator),
                      SizedBox(height: height * 0.02),
                      CustomButton(
                          text: 'Signup',
                          isLoading: isLoading,
                          onPressed: () => {
                                if (_formKey.currentState!.validate())
                                  {signUp()}
                              }),
                    ],
                  )),
              SizedBox(height: height * 0.025),
              const OrDivider(),
              SizedBox(
                height: height * 0.025,
              ),
              const GoogleSigninButton(),
              SizedBox(height: height * 0.03),
              Center(
                child: InkWell(
                  onTap: () {
                    Routemaster.of(context).push('/login');
                  },
                  child: const Text('Already have an account? Log in',
                      style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: Pallete.textGrey)),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
