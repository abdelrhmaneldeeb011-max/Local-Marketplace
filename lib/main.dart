// بسم الله الرحمن الرحيم //
import 'screens/Login_Screen.dart';
import 'screens/signUp_screen.dart';
import 'screens/customer_home_screen.dart'; // ✅ استدعاء صفحة الـ Home
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // التأكد من تهيئة الـ Widgets قبل بدء التطبيق
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar'), Locale('en')],
      fallbackLocale: const Locale('ar'),
      child: const Wafrnalak(),
    ),
  );
}

class Wafrnalak extends StatelessWidget {
  const Wafrnalak({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // ✅ تعريف الـ routes
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) =>
            const SignUpScreen(), // ✅ التنقل من Login → Signup
        '/home': (context) =>
            const CustomerHomeScreen(), // ✅ التنقل للـ Home بعد تسجيل الدخول
      },
    );
  }
}
