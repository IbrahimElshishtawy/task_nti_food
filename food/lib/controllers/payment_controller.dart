import 'package:get/get.dart';

import '../core/constants/storage_keys.dart';
import '../models/order_model.dart';
import '../services/storage_service.dart';

class PaymentController extends GetxController {
  PaymentController(this._storageService);

  final StorageService _storageService;
  final Rx<PaymentMethod> selectedMethod = PaymentMethod.cashOnDelivery.obs;

  @override
  void onInit() {
    super.onInit();
    final stored = _storageService.read<String>(StorageKeys.paymentMethod);
    selectedMethod.value = PaymentMethodX.fromApi(stored ?? '');
  }

  void selectMethod(PaymentMethod method) {
    selectedMethod.value = method;
    _storageService.write(StorageKeys.paymentMethod, method.apiValue);
  }
}
