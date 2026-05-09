// بسم الله الرحمن الرحيم //
import 'screens/Login_Screen.dart';
import 'screens/signUp_screen.dart';
import 'screens/customer_home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // ✅ Routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const CustomerHomeScreen(),
      },

      // ✅ Auth Gate — بيشوف حالة المستخدم أول ما الـ app يفتح
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // لسه بيحمّل
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // ✅ متسجل دخول وإيميله متفعّل → روح للـ Home
          if (snapshot.hasData && snapshot.data!.emailVerified) {
            return const CustomerHomeScreen();
          }

          // ✅ مش متسجل أو إيميله مش متفعّل → روح للـ Login
          return const LoginScreen();
        },
      ),
    );
  }
}