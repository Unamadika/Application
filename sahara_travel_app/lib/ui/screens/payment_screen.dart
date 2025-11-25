import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/payment_controller.dart';
import '../../models/payment_method.dart';
import '../../ui/widgets/responsive_builder.dart';
import '../../ui/widgets/section_header.dart';

/// Payment screen with cost breakdown and payment methods.
class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: _PaymentLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24)),
      tablet: _PaymentLayout(
          controller: controller,
          padding: const EdgeInsets.symmetric(horizontal: 96, vertical: 40)),
    );
  }
}

class _PaymentLayout extends StatelessWidget {
  const _PaymentLayout({required this.controller, required this.padding});

  final PaymentController controller;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(title: 'Trip summary', subtitle: 'Cost sharing for “Nomad Wellness Retreat”'),
              const SizedBox(height: 16),
              _SummaryCard(total: controller.format(controller.total)),
              const SizedBox(height: 28),
              const SectionHeader(title: 'Cost breakdown'),
              const SizedBox(height: 12),
              ...controller.breakdown.entries.map((entry) => _BreakdownRow(
                  label: entry.key, value: controller.format(entry.value))),
              const Divider(height: 32),
              const SectionHeader(title: 'Payment methods', subtitle: 'Choose your preferred provider'),
              const SizedBox(height: 12),
              ...controller.methods.map((method) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _MethodTile(
                      method: method,
                      selected: controller.selectedMethod.value == method,
                      onTap: () => controller.selectMethod(method),
                    ),
                  )),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar('Payment initiated',
                        'Processing ${controller.selectedMethod.value?.name ?? 'method'}');
                  },
                  icon: const Icon(Icons.lock_outline),
                  label: Text(
                      'Confirm payment • ${controller.format(controller.total)}'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.total});

  final String total;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nomad Wellness Retreat',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('Merzouga, Morocco • 3 days • 4 travellers',
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: Colors.grey.shade600)),
            const SizedBox(height: 16),
            Row(
              children: [
                const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shared savings'),
                      SizedBox(height: 4),
                      Text('MAD 130',
                          style: TextStyle(fontWeight: FontWeight.w600))
                    ]),
                const Spacer(),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Text('Total due'),
                  Text(total,
                      style: theme.textTheme.titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold))
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _MethodTile extends StatelessWidget {
  const _MethodTile(
      {required this.method, required this.selected, required this.onTap});

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: Icon(method.icon, color: theme.colorScheme.primary),
        title: Text(method.name,
            style: theme.textTheme.titleMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(method.description),
        trailing: Icon(
            selected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: selected ? theme.colorScheme.primary : Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
