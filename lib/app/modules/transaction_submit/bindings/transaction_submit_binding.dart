import 'package:get/get.dart';

import '../controllers/transaction_submit_controller.dart';

class TransactionSubmitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionSubmitController>(
      () => TransactionSubmitController(),
    );
  }
}
