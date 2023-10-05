import 'package:flutter/material.dart';
import 'package:iwallet/app/widgets/app_list_tile.dart';

class PickerModel<T> {
  final String? title;
  final List<T> selected;
  final List<T> data;

  PickerModel({
    this.title,
    required this.selected,
    required this.data,
  });
}

class AppBottomPicker extends StatelessWidget {
  final PickerModel picker;

  const AppBottomPicker({
    Key? key,
    required this.picker,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Theme.of(context).dividerColor,
                    ),
                  ),
                  Column(
                    children: picker.data.map((item) {
                      Widget? trailing;
                      Widget? leading;
                      Widget? descWidget;
                      String title = '';
                      if (item is String) {
                        title = item;
                      } else {
                        title = item.title;
                      }

                      if (picker.selected.contains(item)) {
                        trailing = Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        );
                      }

                      if (item == picker.data.last) {
                        return AppListTitle(
                          leading: leading,
                          title: title,
                          trailing: trailing,
                          desc: descWidget,
                          border: false,
                          onPressed: () {
                            Navigator.pop(context, item);
                          },
                        );
                      }
                      return AppListTitle(
                        leading: leading,
                        title: title,
                        trailing: trailing,
                        desc: descWidget,
                        onPressed: () {
                          Navigator.pop(context, item);
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
