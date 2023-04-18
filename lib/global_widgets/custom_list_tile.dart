import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxListTile extends StatelessWidget {
  const NxListTile({
    Key? key,
    this.leading,
    this.title,
    this.subtitle,
    this.padding,
    this.bgColor,
    this.onTap,
    this.onLongPressed,
    this.trailing,
    this.borderRadius,
    this.leadingFlex,
    this.titleFlex,
    this.trailingFlex,
    this.showBorder = true,
  }) : super(key: key);

  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;
  final EdgeInsets? padding;
  final Color? bgColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPressed;
  final BorderRadius? borderRadius;
  final int? leadingFlex;
  final int? titleFlex;
  final int? trailingFlex;
  final bool? showBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Container(
        padding: padding ?? Dimens.edgeInsets12_0,
        width: Dimens.screenWidth,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? Theme.of(context).dialogTheme.backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(Dimens.zero),
          border: showBorder == true
              ? Border.all(
                  color: Theme.of(context).dividerColor,
                  width: Dimens.pointEight,
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (leading != null)
                    Expanded(flex: leadingFlex ?? 0, child: leading!),
                  if (leading != null && (title != null || subtitle != null))
                    Dimens.boxWidth16,
                  Expanded(
                    flex: titleFlex ?? 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (title != null) title!,
                        if (title != null && subtitle != null)
                          Dimens.boxHeight4,
                        if (subtitle != null) subtitle!
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) Dimens.boxWidth12,
            if (trailing != null)
              Expanded(
                flex: trailingFlex ?? 0,
                child: trailing!,
              ),
          ],
        ),
      ),
    );
  }
}
