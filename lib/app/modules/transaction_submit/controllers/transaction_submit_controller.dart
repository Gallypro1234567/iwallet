import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/common/firebase_provider.dart';
import 'package:iwallet/app/common/help_function.dart';
import 'package:iwallet/app/models/category_model.dart';
import 'package:iwallet/app/models/expenses_model.dart';
import 'package:iwallet/app/modules/transaction_submit/views/calendar_view.dart';
import 'package:iwallet/app/widgets/app_bottom_picker.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

enum DateEnum {
  today('Hôm nay', 'today'),
  yesterday('Hôm qua', 'yesterday'),
  orther('Tuỳ chỉnh', 'orther');

  final String title;
  final String value;
  const DateEnum(this.title, this.value);
}

class TransactionSubmitController extends GetxController {
  var isUpdate = false.obs;
  var amount = TextEditingController(text: '').obs;
  var category = Category().obs;
  var date = DateTime.now().obs;
  var timeEnum = DateEnum.today.obs;
  var note = TextEditingController().obs;
  var id = ''.obs;

  var categories = <Category>[].obs;
  var userCategories = <Category>[].obs;

  @override
  void onInit() {
    var list = Category.group().map((e) => e.copyOf()).toList();
    categories.assignAll(list);
    userCategories.assignAll([]); // from firebase id = -7
    if (Get.arguments is Expenses) {
      var data = Get.arguments as Expenses;
      isUpdate.value = true;
      amount.value.text = data.amount.toString();
      category.value = categories.firstWhere((e) => e.id == data.categoryId);
      date.value = data.date!;
      note.value.text = data.note ?? '';
      id.value = data.id!;
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

  bool validated() {
    var amountValue = double.tryParse(amount.value.text.replaceAll(',', ''));
    if (amountValue == null || amountValue < 0) {
      return false;
    }
    if (category.value.id == null) {
      return false;
    }

    return true;
  }

  void onBack(id) {
    category.value = categories.firstWhere((e) => e.id = id);
    Get.back();
  }

  void onShowDatePicker(BuildContext context) async {
    final result = await showModalBottomSheet<DateEnum>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return AppBottomPicker(
          picker: PickerModel(
            selected: [timeEnum.value],
            data: [DateEnum.today, DateEnum.yesterday, DateEnum.orther],
          ),
        );
      },
    );
    if (result != null) {
      timeEnum.value = result;
      if (timeEnum.value != DateEnum.orther) {
        date.value = await getTime(timeEnum.value);
      } else {
        date.value =
            await Get.to(() => const CalendarView()) as DateTime? ?? date.value;
      }
    }
  }

  void onAdd() async {
    var amountValue = double.tryParse(amount.value.text.replaceAll(',', ''));
    if (amountValue == null || amountValue < 0) {
      return;
    }
    if (category.value.id == null) {
      return;
    }

    var model = Expenses(
      amount: amountValue,
      categoryId: category.value.id,
      categoryName: category.value.title,
      categoryType: category.value.type,
      note: note.value.text,
      date: date.value,
    );
    if (Application.user != null) {
      loading();
      if (isUpdate.value) {}
      var res = await FireStoreProvider.addExpense(
          Application.user!.uid, model.toJson());
      Get.back();
      if (res.success) {
        cautionDialog('Lưu thành công', title: 'Thông báo', onDismiss: () {
          Get.back();
        });
        return;
      }
      cautionDialog(res.message, title: 'Thông báo');
    }
  }

  void onUpdate() async {
    var amountValue = double.tryParse(amount.value.text.replaceAll(',', ''));
    if (amountValue == null || amountValue < 0) {
      return;
    }
    if (category.value.id == null) {
      return;
    }

    var model = Expenses(
      amount: amountValue,
      categoryId: category.value.id,
      categoryName: category.value.title,
      categoryType: category.value.type,
      note: note.value.text,
      date: date.value,
    );
    if (Application.user != null) {
      loading();
      if (isUpdate.value) {}
      var res = await FireStoreProvider.updateExpense(
          Application.user!.uid, id.value, model.toJson());
      Get.back();
      if (res.success) {
        cautionDialog('Lưu thành công', title: 'Thông báo', onDismiss: () {
          Get.back();
        });
        return;
      }
      cautionDialog(res.message, title: 'Thông báo');
    }
  }

  Future<DateTime> getTime(DateEnum value) async {
    switch (value) {
      case DateEnum.yesterday:
        DateTime now = DateTime.now();
        return now.subtract(const Duration(days: 1));
      default:
        DateTime now = DateTime.now();
        return now;
    }
  }
}
