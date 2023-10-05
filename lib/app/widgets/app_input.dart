import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppInputText extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? leading;
  final Widget? trailing;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? errorText;
  final int? maxLines;
  final bool? autofocus;
  final List<TextInputFormatter>? inputFormatter;

  final String? unit;
  final bool? isBackgroundColor;
  final bool? isShowSuffixIcon;

  final bool bigText;
  final ImageFilter? imageFilter;
  final TextStyle? style;
  const AppInputText({
    super.key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.leading,
    this.trailing,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.maxLines = 1,
    this.autofocus = false,
    this.inputFormatter,
    this.unit,
    this.bigText = false,
    this.isBackgroundColor = false,
    this.isShowSuffixIcon = true,
    this.imageFilter,
    this.style,
  });

  @override
  State<AppInputText> createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget leadingWidget = const SizedBox(width: 16);
    Widget deleteAction = Container();

    if (widget.leading != null) {
      leadingWidget = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          widget.leading!,
          const SizedBox(width: 8),
        ],
      );
    }

    if (widget.controller != null && widget.controller!.text.isNotEmpty) {
      deleteAction = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          GestureDetector(
            dragStartBehavior: DragStartBehavior.down,
            onTap: () {
              widget.controller!.clear();
              if (widget.onChanged != null) {
                setState(() {
                  widget.onChanged!(widget.controller!.text);
                });
              }
            },
            child: Row(
              children: [
                if (widget.unit != null) Text(widget.unit!),
                if (widget.isShowSuffixIcon!)
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).highlightColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.clear,
                      size: 20,
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: (widget.isBackgroundColor!
                    ? Theme.of(context).scaffoldBackgroundColor
                    : Get.isDarkMode
                        ? Theme.of(context).cardColor
                        : Colors.white)
                .withOpacity(0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Row(
                children: [
                  leadingWidget,
                  Expanded(
                    child: TextField(
                      inputFormatters: widget.inputFormatter,
                      onTap: widget.onTap,
                      textAlignVertical: TextAlignVertical.center,
                      onSubmitted: widget.onSubmitted,
                      controller: widget.controller,
                      focusNode: widget.focusNode,
                      onChanged: widget.onChanged,
                      obscureText: widget.obscureText,
                      keyboardType: widget.keyboardType,
                      textInputAction: widget.textInputAction,
                      maxLines: widget.maxLines,
                      style: widget.style ??
                          (widget.bigText
                              ? Theme.of(context).textTheme.headlineMedium
                              : null),
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: widget.style,
                        labelStyle: widget.style,
                        labelText: widget.controller!.text.isNotEmpty
                            ? widget.hintText
                            : null,
                        suffixIcon: widget.maxLines! > 1
                            ? null
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  widget.trailing ?? Container(),
                                  deleteAction,
                                  const SizedBox(width: 12)
                                ],
                              ),
                        border: InputBorder.none,
                      ),
                      autofocus: widget.autofocus ?? false,
                    ),
                  )
                ],
              ),
              if (widget.maxLines! > 1)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: deleteAction,
                )
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        _buildErrorLabel(context)
      ],
    );
  }

  Widget _buildErrorLabel(BuildContext context) {
    if (widget.errorText == null || widget.errorText!.isEmpty) {
      return Container();
    }
    if (widget.leading != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                widget.errorText!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.red),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              widget.errorText!,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.red),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
