// بسم الله الرحمن الرحيم //
import 'screens/Login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  // التأكد من تهيئة الـ Widgets قبل بدء التطبيق
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      // مسار ملفات الترجمة في مشروعك
      path: 'assets/translations', 
      // اللغات المدعومة (مثلاً العربية والإنجليزية)
      supportedLocales: const [Locale('ar'), Locale('en')],
      // اللغة الافتراضية
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
      // ربط إعدادات اللغة بالتطبيق
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      
      // شاشة البداية
      home: LoginScreen(),
    );
  }
}