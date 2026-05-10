// بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/auth_service.dart';
import '../customer/customer_home_screen.dart';
import 'ForgotPasswordScreen.dart';
import 'signUp_screen.dart';
import '../../app_bar.dart';
import '../../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../../loginAndSignupWidgets/widgets/custom_field.dart';
import '../../loginAndSignupWidgets/widgets/loginWith.dart';
import '../../loginAndSignupWidgets/widgets/marketImage.dart';
import '../../loginAndSignupWidgets/widgets/orDivider.dart';
import '../../loginAndSignupWidgets/widgets/passwordField.dart';
import '../../loginAndSignupWidgets/widgets/welcomeMassage.dart';

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
      _showError('Please enter email and password');
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
                controller: _emailController,
                label: 'email'.tr(),
                hint: 'example@mail.com',
                icon: Icons.email,
              ),
              const SizedBox(height: 10),
              Passwordfield(
                controller: _passwordController,
                text: 'password'.tr(),
                forgetPasswordText: 'forgotPassword'.tr(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ForgotPasswordScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: InkWell(
                  onTap: _isLoading ? null : _handleLogin,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _isLoading ? Colors.grey : Colors.deepOrange,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'login'.tr(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
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
