import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/common/firebase_provider.dart';
import 'package:iwallet/app/models/expenses_model.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

class TransactionDetailController extends GetxController {
  var data = Expenses().obs;

  var amount = TextEditingController().obs;

  var note;
  @override
  void onInit() {
    if (Get.arguments is Expenses) {
      data.value = Get.arguments;
      print(data.value.id);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  onShowDatePicker(BuildContext context) {}
  onDeleteEx() async {
    cautionDialog('Xoá giao dịch này', title: 'Thông báo', onDismiss: () {
      FireStoreProvider.deleteExpense(Application.user!.uid, data.value.id!);
      Get.back();
    });
  }
}
