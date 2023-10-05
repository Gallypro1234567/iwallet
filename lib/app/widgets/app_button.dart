import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String title;
  final Widget? leading;
  final Widget? trailing;
  final double width;
  final VoidCallback voidCallback;
  final Color? backgroundColor;
  const AppButton({
    super.key,
    required this.title,
    required this.width,
    required this.voidCallback,
    this.backgroundColor,
    this.leading,
    this.trailing,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget.voidCallback,
      onLongPress: widget.voidCallback,
      borderRadius: BorderRadius.circular(4),
      child: Ink(
        width: size.width / widget.width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.leading ?? Container(),
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            widget.trailing ?? Container(),
          ],
        ),
      ),
    );
  }
}
