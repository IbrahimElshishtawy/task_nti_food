import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/payment_controller.dart';
import '../../models/order_model.dart';
import '../../widgets/payment_option_tile.dart';

class PaymentMethodsView extends GetView<PaymentController> {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    const methods = <PaymentMethod>[
      PaymentMethod.cashOnDelivery,
      PaymentMethod.creditCard,
      PaymentMethod.wallet,
    ];

    return Scaffold(
      appBar: AppBar(title: Text('payment_methods'.tr)),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        itemCount: methods.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final method = methods[index];
          return Obx(
            () => PaymentOptionTile(
              method: method,
              selected: controller.selectedMethod.value == method,
              onTap: () {
                controller.selectMethod(method);
                Get.back<void>();
              },
            ),
          );
        },
      ),
    );
  }
}
