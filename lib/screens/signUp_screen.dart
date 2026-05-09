// بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../app_bar.dart';
import 'Login_Screen.dart';
import '../../services/auth_service.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginButton.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/role.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('من فضلك ادخل كل البيانات');
      return;
    }

    if (password != confirmPassword) {
      _showError('الباسورد مش متطابق، تأكد منه');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.register(email, password, name);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم التسجيل! تحقق من إيميلك لتفعيل الحساب'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 4),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } on AuthException catch (e) {
      if (mounted) _showError(e.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 30),
          children: [
            WelcomeMessage(text1: "signupMassage1", text2: "signupMassage2"),
            Marketimage(),
            const SizedBox(height: 20),
            const Role(),
            const SizedBox(height: 20),
            CustomInputField(
              label: 'fullName'.tr(),
              icon: Icons.person,
              hint: 'fullName'.tr(),
              controller: _nameController,
            ),
            const SizedBox(height: 10),
            CustomInputField(
              label: 'email'.tr(),
              icon: Icons.email,
              hint: 'email'.tr(),
              controller: _emailController,
            ),
            const SizedBox(height: 10),
            Passwordfield(
              text: 'password',
              forgetPasswordText: '',
              controller: _passwordController,
            ),
            const SizedBox(height: 10),
            Passwordfield(
              text: 'confirmPassword',
              forgetPasswordText: '',
              controller: _confirmPasswordController,
            ),
            const SizedBox(height: 25),
            Loginbutton(
              text: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                      'signup'.tr(),
                      style: const TextStyle(color: Colors.white),
                    ),
              onPressed: _isLoading ? null : _handleSignUp,
            ),
            const SizedBox(height: 20),
            OrDivider(),
            const SizedBox(height: 15),
            const Loginwith(),
            Alreadyhaveaccount(
              text1: 'alreadyHaveAccount',
              text2: 'login',
              fun: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}