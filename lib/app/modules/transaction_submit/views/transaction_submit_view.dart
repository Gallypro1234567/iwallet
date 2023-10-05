import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iwallet/app/common/help_function.dart';
import 'package:iwallet/app/modules/transaction_submit/views/note_view.dart';
import 'package:iwallet/app/routes/app_pages.dart';
import 'package:iwallet/app/widgets/app_bottom_picker.dart';
import 'package:iwallet/app/widgets/app_input.dart';
import 'package:iwallet/app/widgets/app_picker_item.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../controllers/transaction_submit_controller.dart';

class TransactionSubmitView extends StatefulWidget {
  const TransactionSubmitView({Key? key}) : super(key: key);

  @override
  State<TransactionSubmitView> createState() => _TransactionSubmitViewState();
}

class _TransactionSubmitViewState extends State<TransactionSubmitView> {
  final controller = TransactionSubmitController();
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        removeFocus(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Add Transaction',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            Obx(
              () => Opacity(
                opacity: controller.validated() ? 1 : 0.4,
                child: TextButton(
                  onPressed: controller.validated()
                      ? () {
                          controller.isUpdate.value
                              ? controller.onUpdate()
                              : controller.onAdd();
                        }
                      : null,
                  child: Text(
                    'Save'.toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Container(
            color: Theme.of(context).cardColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => AppInputText(
                    hintText: 'Số tiền',
                    controller: controller.amount.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 22),
                    leading: Container(
                      width: 48,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0, color: Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text('VND'),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (v) {
                      controller.amount.refresh();
                    },
                    inputFormatter: [ThousandsFormatter(allowFraction: true)],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 48 + 16,
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => AppPickerItem(
                    title: controller.category.value.id == null
                        ? 'Chọn nhóm'
                        : controller.category.value.title ?? '',
                    leading: Container(
                      width: 48,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.content_paste, color: Colors.indigo),
                    ),
                    fontSize: 22,
                    onPressed: onSelectCategories,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 48 + 16,
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => AppPickerItem(
                    title: controller.note.value.text.isEmpty
                        ? 'Ghi chú'
                        : controller.note.value.text,
                    leading: Container(
                      width: 48,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.notes, color: Colors.purple),
                    ),
                    onPressed: onAddNote,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 48 + 16,
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => AppPickerItem(
                    title: getDateTime(controller.date.value),
                    leading: Container(
                      width: 48,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.cyan.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.access_alarm, color: Colors.cyan),
                    ),
                    onPressed: () => controller.onShowDatePicker(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 48 + 16,
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
                AppPickerItem(
                  title: 'Tiền mặt',
                  leading: Container(
                    width: 48,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.attach_money, color: Colors.green),
                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 48 + 16,
                      ),
                      Expanded(
                        child: Divider(
                          height: 1.0,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onSelectCategories() async {
    removeFocus(context);
    final selected = await Get.toNamed(Routes.CATEGORY,
        arguments: controller.category.value);
    if (selected != null) {
      controller.category.value = selected;
    }
  }

  void onAddNote() async {
    removeFocus(context);
    final selected =
        await Get.to(() => NoteView(note: controller.note.value.text));
    if (selected != null) {
      controller.note.value.text = selected;
    }
  }
}
