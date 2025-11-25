import 'package:get/get.dart';

import '../models/payment_method.dart';
import '../services/payment_service.dart';

class PaymentController extends GetxController {
  final PaymentService _service = PaymentService();

  final methods = <PaymentMethod>[].obs;
  final breakdown = <String, double>{}.obs;
  final isLoading = true.obs;
  final selectedMethod = Rxn<PaymentMethod>();

  @override
  void onInit() {
    super.onInit();
    loadPaymentData();
  }

  Future<void> loadPaymentData() async {
    isLoading.value = true;
    final results = await Future.wait([
      _service.fetchCostBreakdown(),
      _service.fetchMethods(),
    ]);
    breakdown.assignAll(results[0] as Map<String, double>);
    methods.assignAll(results[1] as List<PaymentMethod>);
    selectedMethod.value = methods.first;
    isLoading.value = false;
  }

  double get total => breakdown.values.fold(0, (sum, value) => sum + value);

  String format(double value) => _service.formatCurrency(value);

  void selectMethod(PaymentMethod method) {
    selectedMethod.value = method;
  }
}
