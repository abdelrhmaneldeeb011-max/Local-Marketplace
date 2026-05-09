// بسم الله الرحمن الرحيم //
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// ✅ Custom Exception عشان نعرف إيه المشكلة بالظبط
class AuthException implements Exception {
  final String message;
  final String code;
  AuthException({required this.message, required this.code});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ✅ Stream للـ UI يستمع لحالة المستخدم
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ✅ التحقق من قوة الباسورد
  bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // ✅ تسجيل الدخول مع Error Messages واضحة
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          debugPrint("✅ User Logged In: ${user.email}");
          return user;
        } else {
          // ✅ بنعمل sign out عشان ميفضلش logged in من غير تأكيد
          await _auth.signOut();
          throw AuthException(
            code: 'email-not-verified',
            message: 'من فضلك فعّل إيميلك الأول.\nتحقق من inbox بتاعك.',
          );
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: _getArabicErrorMessage(e.code),
      );
    }
  }

  // ✅ تسجيل مستخدم جديد مع الاسم + Email Verification
  Future<User?> register(String email, String password, String name) async {
    // ✅ التحقق من قوة الباسورد قبل ما نبعت للـ Firebase
    if (!isPasswordStrong(password)) {
      throw AuthException(
        code: 'weak-password',
        message:
            'الباسورد لازم يكون:\n• 8 حروف على الأقل\n• حرف كبير\n• رقم\n• رمز خاص مثل (!@#)',
      );
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      User? user = userCredential.user;

      if (user != null) {
        // ✅ حفظ الاسم في Firebase
        await user.updateDisplayName(name.trim());
        debugPrint("✅ User Registered: ${user.email}");

        // ✅ إرسال إيميل تأكيد
        await user.sendEmailVerification();
        debugPrint("📧 Verification email sent to: ${user.email}");

        // ✅ Sign out بعد التسجيل عشان يفعّل الإيميل الأول
        await _auth.signOut();
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: _getArabicErrorMessage(e.code),
      );
    }
  }

  // ✅ إعادة إرسال إيميل التفعيل
  Future<void> resendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      debugPrint("📧 Verification email re-sent to: ${user.email}");
    } else {
      throw AuthException(
        code: 'no-user',
        message: 'مفيش مستخدم logged in حالياً.',
      );
    }
  }

  // ✅ إعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      debugPrint("📧 Password reset email sent to: $email");
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: _getArabicErrorMessage(e.code),
      );
    }
  }

  // ✅ التحقق لو الإيميل اتفعّل
  Future<bool> checkEmailVerified() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  // ✅ تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    debugPrint("✅ User Logged Out");
  }

  // ✅ المستخدم الحالي
  User? get currentUser => _auth.currentUser;

  // ✅ ترجمة Firebase error codes لرسائل عربية
  String _getArabicErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'الإيميل ده مش مسجل عندنا.';
      case 'wrong-password':
        return 'الباسورد غلط، حاول تاني.';
      case 'email-already-in-use':
        return 'الإيميل ده مسجل قبل كده.';
      case 'invalid-email':
        return 'صيغة الإيميل غلط.';
      case 'too-many-requests':
        return 'محاولات كتير أوي، استنى شوية وحاول تاني.';
      case 'network-request-failed':
        return 'مفيش إنترنت، تحقق من الاتصال.';
      case 'user-disabled':
        return 'الحساب ده اتوقف. تواصل مع الدعم.';
      case 'invalid-credential':
        return 'الإيميل أو الباسورد غلط.';
      default:
        return 'حصل خطأ غير متوقع، حاول تاني.';
    }
  }
}
