import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iwallet/app/widgets/app_input.dart';

class NoteView extends StatefulWidget {
  final String? note;
  const NoteView({super.key, this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  var note = TextEditingController().obs;
  @override
  void initState() {
    note.value.text = widget.note ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Note',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(result: note.value.text);
            },
            child: Text(
              'Save'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        child: Obx(
          () => AppInputText(
            autofocus: true,
            controller: note.value,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            isShowSuffixIcon: false,
          ),
        ),
      ),
    );
  }
}
