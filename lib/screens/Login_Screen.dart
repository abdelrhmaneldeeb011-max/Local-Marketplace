// بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:wafrnalak/screens/customer/customer_home_screen.dart';
import '../app_bar.dart';
import 'signUp_screen.dart';
import 'ForgotPasswordScreen.dart';
import '../../services/auth_service.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginButton.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('من فضلك ادخل الإيميل والباسورد');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _authService.login(email, password);
      if (user != null && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
          (route) => false,
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
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(),
      body: PopScope(
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.only(top: 30),
            children: [
              WelcomeMessage(
                text1: "welcomeMessage1",
                text2: "welcomeMessage2",
              ),
              Marketimage(),
              const SizedBox(height: 20),
              CustomInputField(
                label: 'email'.tr(),
                hint: 'example@mail.com',
                icon: Icons.email,
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              Passwordfield(
                text: 'password',
                forgetPasswordText: 'forgotPassword',
                controller: _passwordController,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Loginbutton(
                text: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'login',
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: _isLoading ? null : _handleLogin,
              ),
              const SizedBox(height: 20),
              OrDivider(),
              const SizedBox(height: 15),
              const Loginwith(),
              Alreadyhaveaccount(
                text1: 'noAccount',
                text2: 'signup',
                fun: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}