import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void loading({String? loadingText, Function()? onCancel}) async {
  await Get.dialog(
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CupertinoActivityIndicator(),
        const SizedBox(height: 8.0),
        if (loadingText != null)
          Obx(() => Text(loadingText, style: const TextStyle(fontSize: 16))),
      ],
    ),
    barrierDismissible: false,
  );
}

void cautionDialog(String? content,
    {bool center = true,
    bool dismissable = false,
    String? title,
    Function()? onDismiss,
    Function()? onCancel}) async {
  var titleWidget = Text(
    title ?? "Caution!",
  );
  var contentWidget = Text(
    content ?? 'Unknown error',
    textAlign: center ? TextAlign.center : TextAlign.left,
  );
  var actionWidget = [
    if (onCancel != null)
      TextButton(
        onPressed: onCancel,
        child: const Text(
          "Thoát",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    TextButton(
      onPressed: () {
        Get.back();
        if (onDismiss != null) onDismiss();
      },
      child: const Text(
        "OK",
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    ),
  ];

  if (Platform.isIOS) {
    await Get.dialog(
      CupertinoAlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: actionWidget,
      ),
      barrierDismissible: dismissable,
    );
    return;
  }
  if (Platform.isAndroid) {
    await Get.dialog(
      AlertDialog(
        title: titleWidget,
        content: contentWidget,
        actions: actionWidget,
      ),
      barrierDismissible: dismissable,
    );
    return;
  }
}
