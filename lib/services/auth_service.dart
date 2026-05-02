import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isPasswordStrong(String password) {
    if (password.length < 8) return false; // لازم 8 حروف على الأقل
    if (!password.contains(RegExp(r'[A-Z]'))) return false; // لازم حرف كبير
    if (!password.contains(RegExp(r'[0-9]'))) return false; // لازم رقم
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // ✅ تسجيل الدخول
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
          debugPrint("⚠️ Email not verified for: ${user.email}");
          return null; // مش هيدخل إلا لما يفعّل الإيميل
        }
      }
      return null;
    } catch (e) {
      debugPrint("❌ Login Error: $e");
      return null;
    }
  }

  // ✅ تسجيل مستخدم جديد مع Email Verification
  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      User? user = userCredential.user;

      if (user != null) {
        debugPrint("✅ User Registered: ${user.email}");
        // إرسال إيميل تأكيد
        await user.sendEmailVerification();
        debugPrint("📧 Verification email sent to: ${user.email}");
      }

      return user;
    } catch (e) {
      debugPrint("❌ Register Error: $e");
      return null;
    }
  }

  // ✅ Forgot Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      debugPrint("📧 Password reset email sent to: $email");
    } catch (e) {
      debugPrint("❌ Reset Password Error: $e");
    }
  }

  // ✅ تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
    debugPrint("✅ User Logged Out");
  }

  // ✅ المستخدم الحالي
  User? get currentUser => _auth.currentUser;
}
