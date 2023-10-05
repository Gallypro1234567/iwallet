import 'package:get/get.dart';
import 'package:iwallet/app/common/application.dart';
import 'package:iwallet/app/modules/initial/controllers/initial_controller.dart';
import 'package:iwallet/app/modules/navigation/controllers/navigation_controller.dart';
import 'package:iwallet/app/widgets/loading_dialog.dart';

class ProfileController extends GetxController {
  var isDarkMode = false.obs;
  final user = Application.user;
  @override
  void onInit() {
    isDarkMode.value = Application.getKey('is_darkmode') ?? false;
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

  void onLogOut() {
    cautionDialog(
      'Đăng xuất khỏi thiết bị?\n\nDữ liệu của bạn trên thiết bị này sẽ bị xoá, nhưng bạn luôn có thể lấy lại khi đăng nhập lại.',
      title: 'Nhắc nhở',
      onCancel: () {
        Get.back();
      },
      onDismiss: () {
        Get.find<NavigationController>().onLogOut();
      },
    );
  }

  void onChangeModeTheme() {
    final initialController = Get.find<InitialController>();
    initialController.onChangeThemeMode(!isDarkMode.value);
    isDarkMode.value = Application.getKey('is_darkmode') ?? false;
  }
}
