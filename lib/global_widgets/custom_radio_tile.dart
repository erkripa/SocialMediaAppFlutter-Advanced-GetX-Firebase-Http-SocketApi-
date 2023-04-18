import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';

class NxRadioTile extends StatelessWidget {
  const NxRadioTile({
    Key? key,
    required this.onChanged,
    this.value,
    this.groupValue,
    required this.title,
    this.margin,
    this.padding,
    this.titleStyle,
    this.activeColor,
    this.onTap,
    this.bgColor,
    this.borderRadius,
    this.subtitle,
    this.showBorder = false,
  }) : super(key: key);

  final Function(dynamic) onChanged;
  final dynamic value;
  final dynamic groupValue;
  final Widget title;
  final Widget? subtitle;
  final TextStyle? titleStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? activeColor;
  final Function()? onTap;
  final Color? bgColor;
  final BorderRadius? borderRadius;
  final bool? showBorder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.zero),
          border: showBorder == true
              ? Border.all(
                  color: Theme.of(context).dividerColor,
                  width: Dimens.pointEight,
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  title,
                  if (subtitle != null) Dimens.boxHeight2,
                  if (subtitle != null) subtitle!
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: Radio(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                splashRadius: Dimens.four,
                activeColor:
                    activeColor ?? Theme.of(context).colorScheme.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
