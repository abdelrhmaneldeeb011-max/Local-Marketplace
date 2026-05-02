// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginButton.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/role.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;

  // 🔥 function التسجيل
  Future<void> register() async {
    if (_emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please fill all fields").tr()));
      }
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Passwords do not match").tr()));
      }
      return;
    }

    if (context.mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final user = await _authService.register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (context.mounted) {
        setState(() => _isLoading = false);

        if (user != null) {
          // ✅ رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Create account successful").tr()),
          );
          // ✅ بعد النجاح المستخدم يضغط على Login للانتقال
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Signup failed").tr()));
        }
      }
    } catch (e) {
      if (context.mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e").tr()));
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Center(
        child: ListView(
          children: [
            WelcomeMessage(text1: "signupMassage1", text2: "signupMassage2"),
            Marketimage(),

            const SizedBox(height: 20),
            const Role(),

            const SizedBox(height: 20),

            // Name
            CustomInputField(
              controller: _nameController,
              label: 'fullName'.tr(),
              icon: Icons.person,
              hint: 'fullName'.tr(),
            ),

            const SizedBox(height: 10),

            // Email
            CustomInputField(
              controller: _emailController,
              label: 'email'.tr(),
              icon: Icons.email,
              hint: 'email'.tr(),
            ),

            const SizedBox(height: 10),

            // Password
            Passwordfield(
              controller: _passwordController,
              text: 'password',
              forgetPasswordText: '',
            ),

            const SizedBox(height: 10),

            // Confirm Password
            Passwordfield(
              controller: _confirmPasswordController,
              text: 'confirmPassword',
              forgetPasswordText: '',
            ),

            const SizedBox(height: 25),

            // Button
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Loginbutton(text: Text('signup'.tr()), onPressed: register),

            const SizedBox(height: 20),
            OrDivider(),
            const SizedBox(height: 15),
            const Loginwith(),

            // ✅ زرار Login بعد إنشاء الحساب
            Alreadyhaveaccount(
              text1: 'alreadyHaveAccount',
              text2: 'login',
              fun: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
