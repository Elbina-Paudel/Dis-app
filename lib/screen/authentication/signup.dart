import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';

import '../../constants/app_colors.dart';
import '../../widgets/app_button.dart';
import 'auth_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isHidden = true;
  bool _isLoading = false;

  _signUp() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      if (user.user != null) {
        Navigator.pushReplacementNamed(context, '/auth');
      }
    } catch (e) {
      debugPrint('Error: $e'); // Use debugPrint instead of print
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Create Your Account With",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Intelliaid",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: AppColors.instance.lightBrown,
                  ),
                ),
                Image.asset(
                  "assets/logo.gif",
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height - 300,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.instance.darkBrown,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: AppColors.instance.whiteColor,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(24),
                        AuthTextField(
                          labelText: "Fullname",
                          hintText: "Enter Your Name",
                          controller: _fullnameController,
                        ),
                        const Gap(16),
                        AuthTextField(
                          labelText: "Email",
                          hintText: "Enter Your email",
                          controller: _emailController,
                        ),
                        const Gap(16),
                        AuthTextField(
                          labelText: "Password",
                          hintText: "Enter Your Password",
                          isObscureText: _isHidden,
                          controller: _passwordController,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isHidden = !_isHidden;
                              });
                            },
                            icon: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        const Gap(32),
                        Center(
                          child: AppButton(
                            btnTxt: "Register",
                            onTap: _signUp,
                          ),
                        ),
                        const Gap(16),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              'Go Back? Sign in',
                              style: TextStyle(
                                color: AppColors.instance.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
