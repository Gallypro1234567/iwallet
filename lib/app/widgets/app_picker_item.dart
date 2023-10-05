import 'package:flutter/material.dart';

class AppPickerItem extends StatelessWidget {
  final String title;
  final String? value;
  final Widget? leading;
  final bool loading;
  final bool? isBackgroundColor;
  final VoidCallback? onPressed;
  final double? fontSize;
  final bool? isShowTrailing;
  const AppPickerItem({
    Key? key,
    required this.title,
    this.value,
    this.leading,
    this.loading = false,
    this.isBackgroundColor,
    this.onPressed,
    this.fontSize,
    this.isShowTrailing = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget labelWidget = Container();
    Widget valueWidget = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).hintColor, fontSize: fontSize),
      ),
    );

    if (value != null && value!.isNotEmpty) {
      labelWidget = Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: fontSize),
      );
      valueWidget = Text(
        value!,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: fontSize),
      );
    }

    Widget trailingWidget = Icon(
      Icons.keyboard_arrow_right,
      color: onPressed == null ? Colors.grey : Colors.grey,
    );
    if (loading) {
      trailingWidget = const Padding(
        padding: EdgeInsets.all(4),
        child: SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      );
    }

    Widget leadingWidget = const SizedBox(width: 16);
    if (leading != null) {
      leadingWidget = Row(
        children: [
          const SizedBox(width: 8),
          leading!,
          const SizedBox(width: 8),
        ],
      );
    }

    return InkWell(
      onTap: loading ? null : onPressed,
      onLongPress: loading ? null : onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: fontSize != null
            ? const EdgeInsets.symmetric(vertical: 8.0)
            : EdgeInsets.zero,
        decoration: BoxDecoration(
          color: isBackgroundColor ?? false
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            leadingWidget,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelWidget,
                  valueWidget,
                ],
              ),
            ),
            if (isShowTrailing ?? false) trailingWidget,
            const SizedBox(width: 12)
          ],
        ),
      ),
    );
  }
}
