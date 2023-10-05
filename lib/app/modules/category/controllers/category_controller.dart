import 'package:get/get.dart';
import 'package:iwallet/app/models/category_model.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var userCategories = <Category>[].obs;

  var category = Category().obs;

  @override
  void onInit() {
    if (Get.arguments is Category) {
      category.value = Get.arguments;
    }
    var list = Category.group().map((e) => e.copyOf()).toList();
    categories.assignAll(list);
    userCategories.assignAll([]); // from firebase id = -7
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

  void onBack() {
    Get.back(result: category.value);
  }
}
