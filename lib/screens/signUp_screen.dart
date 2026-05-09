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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> register() async {
    // ✅ التحقق من الحقول الفاضية
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Please fill all fields").tr()));
      }
      return;
    }

    // ✅ التحقق من تطابق الباسورد
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
        _nameController.text.trim(), // ✅ بنبعت الاسم
      );

      if (context.mounted) {
        setState(() => _isLoading = false);

        if (user != null) {
          // ✅ Dialog يقول للمستخدم يفتح إيميله
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Row(
                children: [
                  Text('📧 '),
                  Text(
                    'تحقق من إيميلك',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text(
                'اتبعت إيميل تأكيد على:\n${user.email}\n\nافتحه وفعّل حسابك الأول عشان تقدر تسجّل دخول.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, height: 1.6),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // ✅ اقفل الـ Dialog
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'روح لتسجيل الدخول',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }
      }

      // ✅ AuthException — رسائل عربية واضحة من auth_service
    } on AuthException catch (e) {
      if (context.mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.red.shade700,
            duration: const Duration(seconds: 4),
          ),
        );
      }

      // ✅ أي خطأ تاني غير متوقع
    } catch (e) {
      if (context.mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('حصل خطأ غير متوقع، حاول تاني.'),
            backgroundColor: Colors.red,
          ),
        );
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

            // ✅ Name Field
            CustomInputField(
              controller: _nameController,
              label: 'fullName'.tr(),
              icon: Icons.person,
              hint: 'fullName'.tr(),
            ),

            const SizedBox(height: 10),

            // ✅ Email Field
            CustomInputField(
              controller: _emailController,
              label: 'email'.tr(),
              icon: Icons.email,
              hint: 'email'.tr(),
            ),

            const SizedBox(height: 10),

            // ✅ Password Field
            Passwordfield(
              controller: _passwordController,
              text: 'password',
              forgetPasswordText: '',
            ),

            const SizedBox(height: 10),

            // ✅ Confirm Password Field
            Passwordfield(
              controller: _confirmPasswordController,
              text: 'confirmPassword',
              forgetPasswordText: '',
            ),

            const SizedBox(height: 25),

            // ✅ زرار Signup مع Loading
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Loginbutton(text: Text('signup'.tr()), onPressed: register),

            const SizedBox(height: 20),
            OrDivider(),
            const SizedBox(height: 15),
            const Loginwith(),

            // ✅ الانتقال لصفحة Login
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
