import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/api_service.dart';

class RegisterController extends GetxController {
  RegisterController({ApiService? api}) : _api = api ?? ApiService();

  final ApiService _api;

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final bioCtrl = TextEditingController();

  final selectedRole = 'user'.obs;
  final isLoading = false.obs;

  Future<void> register() async {
    if (nameCtrl.text.isEmpty ||
        emailCtrl.text.isEmpty ||
        passwordCtrl.text.isEmpty) {
      Get.snackbar('Missing info', 'Name, email, and password are required.');
      return;
    }

    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      Get.snackbar('Password mismatch', 'Passwords do not match.');
      return;
    }

    try {
      isLoading.value = true;
      final sanitizedPhone = phoneCtrl.text.trim();
      final sanitizedBio = bioCtrl.text.trim();
      final user = await _api.register(
        name: nameCtrl.text.trim(),
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text,
        role: selectedRole.value,
        phone: sanitizedPhone.isEmpty ? '' : sanitizedPhone,
        bio: sanitizedBio.isEmpty ? '' : sanitizedBio,
      );
      _handleAuthSuccess(user);
    } on ApiException catch (e) {
      debugPrint('Register API error: ${e.message}');
      Get.snackbar('Registration failed', e.message);
    } catch (e, stack) {
      debugPrint('Register unexpected error: $e');
      debugPrintStack(stackTrace: stack);
      Get.snackbar('Registration failed', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void _handleAuthSuccess(AuthUser user) {
    if (user.role == 'guide') {
      Get.offAllNamed(AppRoutes.guideDashboard, arguments: user);
    } else {
      Get.offAllNamed(AppRoutes.root, arguments: user);
    }
  }

  @override
  void onClose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    phoneCtrl.dispose();
    bioCtrl.dispose();
    super.onClose();
  }
}

