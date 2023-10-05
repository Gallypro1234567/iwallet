import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iwallet/app/models/category_model.dart';
import 'package:iwallet/app/widgets/app_list_tile.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chọn nhóm',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                child: Text(
                  'Chi tiêu hàng tháng',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  var list = controller.categories
                      .where((p) => p.parenpId == -1)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Obx(
                      () => _buildItem(context, list, index),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                child: Text(
                  'Chi tiêu cần thiết',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  var list = controller.categories
                      .where((p) => p.parenpId == -2)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Obx(
                      () => _buildItem(context, list, index),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                child: Text(
                  'Vui - chơi',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  var list = controller.categories
                      .where((p) => p.parenpId == -3)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Obx(
                      () => _buildItem(context, list, index),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                child: Text(
                  'Đầu tư, Cho vay & Nợ',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  var list = controller.categories
                      .where((p) => p.parenpId == -4)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Obx(
                      () => _buildItem(context, list, index),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                child: Text(
                  'Khoản thu',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  var list = controller.categories
                      .where((p) => p.parenpId == -5)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Obx(
                      () => _buildItem(context, list, index),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                child: Text(
                  'Khác',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  var list = controller.categories
                      .where((p) => p.parenpId == -6)
                      .toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) => Obx(
                      () => _buildItem(context, list, index),
                    ),
                  );
                },
              ),
              Obx(() {
                if (controller.userCategories.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: Container(
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add_circle,
                            color: Colors.green,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Nhóm mới',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 16,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 20 + 8, 8, 8),
                      child: Text(
                        'Nhóm mới',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    Obx(
                      () {
                        var list = controller.userCategories.toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          itemBuilder: (context, index) =>
                              Obx(() => _buildItem(context, list, index)),
                        );
                      },
                    ),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, List<Category> list, int index) {
    return Container(
      color: Theme.of(context).cardColor,
      child: AppListTitle(
        title: list[index].title as String,
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.indigo.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.content_paste, color: Colors.indigo),
        ),
        trailing: controller.category.value.id == list[index].id
            ? Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              )
            : null,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
        border: index == list.length,
        onPressed: () {
          controller.category.value = list[index];
          controller.onBack();
        },
      ),
    );
  }
}
