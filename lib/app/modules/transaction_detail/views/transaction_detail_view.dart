import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iwallet/app/common/help_function.dart';
import 'package:iwallet/app/routes/app_pages.dart';
import 'package:iwallet/app/widgets/app_list_tile.dart';
import 'package:iwallet/app/widgets/app_picker_item.dart';

import '../controllers/transaction_detail_controller.dart';

class TransactionDetailView extends StatefulWidget {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  State<TransactionDetailView> createState() => _TransactionDetailViewState();
}

class _TransactionDetailViewState extends State<TransactionDetailView> {
  final controller = TransactionDetailController();
  @override
  void initState() {
    controller.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sổ giao dịch'),
        centerTitle: false,
        titleSpacing: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(Routes.TRANSACTION_SUBMIT,
                  arguments: controller.data.value);
            },
            child: Text(
              'Sửa'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Obx(
                  () => AppPickerItem(
                    title: controller.data.value.categoryName ?? '',
                    leading: Container(
                      width: 48,
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.category),
                    ),
                    fontSize: 18,
                    onPressed: () {},
                    isShowTrailing: false,
                  ),
                ),
                AppListTitle(
                  title: controller.data.value.amount.toString(),
                  leading: const SizedBox(width: 32),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 22),
                ),
                Obx(
                  () => AppPickerItem(
                    title: getDateTime(controller.data.value.date!),
                    leading: Container(
                      width: 48,
                      padding: const EdgeInsets.all(8.0),
                      child: const Icon(Icons.calendar_today),
                    ),
                    isShowTrailing: false,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 48 + 16),
                    Expanded(
                      child: Divider(
                        height: 1.0,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ],
                ),
                AppPickerItem(
                  title: 'Tiền mặt',
                  leading: Container(
                    width: 48,
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(Icons.wallet),
                  ),
                  onPressed: () {},
                  isShowTrailing: false,
                ),
                Row(
                  children: [
                    const SizedBox(width: 48 + 16),
                    Expanded(
                      child: Divider(
                        height: 1.0,
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: controller.onDeleteEx,
            child: Ink(
              padding: const EdgeInsets.all(12.0),
              color: Theme.of(context).cardColor,
              child: Center(
                child: Text(
                  'Xoá giao dịch',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
