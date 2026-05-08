// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginButton.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  Future<void> _login() async {
    // ✅ التحقق من الحقول الفاضية
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter email and password').tr()),
        );
      }
      return;
    }

    if (context.mounted) {
      setState(() => _isLoading = true);
    }

    try {
      final user = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (context.mounted) {
        setState(() => _isLoading = false);

        if (user != null) {
          // ✅ رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful').tr()),
          );
          // ✅ التوجيه للـ Home
          Navigator.pushReplacementNamed(context, '/home');
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            WelcomeMessage(text1: "welcomeMessage1", text2: "welcomeMessage2"),
            Marketimage(),
            const SizedBox(height: 20),

            // ✅ Email Field
            CustomInputField(
              controller: _emailController,
              label: 'email'.tr(),
              hint: 'example@mail.com',
              icon: Icons.email,
            ),

            const SizedBox(height: 10),

            // ✅ Password Field مع Forgot Password
            Passwordfield(
              controller: _passwordController,
              text: 'password'.tr(),
              forgetPasswordText: 'forgotPassword'.tr(),
              // ✅ ربط زرار Forgot Password بالصفحة
              onTap: () {
                Navigator.pushNamed(context, '/forgot-password');
              },
            ),

            const SizedBox(height: 25),

            // ✅ زرار Login مع Loading
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Loginbutton(text: Text('login'.tr()), onPressed: _login),

            const SizedBox(height: 20),
            OrDivider(),
            const SizedBox(height: 15),
            const Loginwith(),

            // ✅ الانتقال لصفحة Signup
            Alreadyhaveaccount(
              text1: 'noAccount',
              text2: 'signup',
              fun: () {
                Navigator.pushReplacementNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}