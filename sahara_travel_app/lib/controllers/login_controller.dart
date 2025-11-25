import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/api_service.dart';

class LoginController extends GetxController {
  LoginController({ApiService? api}) : _api = api ?? ApiService();

  final ApiService _api;

  final emailCtrl = TextEditingController(text: 'you@example.com');
  final passwordCtrl = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (emailCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      Get.snackbar('Missing info', 'Please enter both email and password.');
      return;
    }

    try {
      isLoading.value = true;
      final user = await _api.login(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text,
      );
      _handleAuthSuccess(user);
    } on ApiException catch (e) {
      debugPrint('Login API error: ${e.message}');
      Get.snackbar('Login failed', e.message);
    } catch (e, stack) {
      debugPrint('Login unexpected error: $e');
      debugPrintStack(stackTrace: stack);
      Get.snackbar('Login failed', e.toString());
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
}
