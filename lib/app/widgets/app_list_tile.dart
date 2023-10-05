import 'package:flutter/material.dart';

class AppListTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? desc;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final bool border;
  final bool? hasBorderRadius;
  final TextStyle? style;
  const AppListTitle({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onPressed,
    this.border = true,
    this.desc,
    this.hasBorderRadius,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Border? borderWidget;
    Widget subTitle = Container();
    Widget leadingWidget = const SizedBox(width: 16);
    // Widget descWidget = const SizedBox(width: 16);
    if (leading != null) {
      leadingWidget = Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: leading,
      );
    }

    if (subtitle != null) {
      subTitle = Text(
        subtitle!,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).primaryColor,
            fontSize: 12,
            fontWeight: FontWeight.w300),
      );
    }
    if (border) {
      borderWidget = Border(
        bottom: BorderSide(
          width: 1,
          color: Theme.of(context).dividerColor,
        ),
      );
    }
    return InkWell(
      onTap: onPressed,
      borderRadius:
          (hasBorderRadius ?? false) ? BorderRadius.circular(10) : null,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius:
              (hasBorderRadius ?? false) ? BorderRadius.circular(10) : null,
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            leadingWidget,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: borderWidget,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  style: style ??
                                      Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                ),
                                subTitle
                              ],
                            ),
                            desc ?? Container(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: trailing ?? Container(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
