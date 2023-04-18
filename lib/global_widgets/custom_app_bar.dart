import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/routes/route_management.dart';

class AyushAppBar extends StatelessWidget {
  const AyushAppBar({
    Key? key,
    this.title,
    this.showDivider = false,
    this.child,
    this.showBackBtn = true,
    this.padding,
    this.titleStyle,
    this.bgColor,
    this.backBtnColor,
  }) : super(key: key);

  final String? title;
  final TextStyle? titleStyle;
  final bool? showDivider;
  final Widget? child;
  final Color? backBtnColor;
  final bool? showBackBtn;
  final EdgeInsets? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.screenWidth,
      color: bgColor ?? Colors.transparent,
      child: Padding(
        padding: padding ?? Dimens.edgeInsets8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (showBackBtn == true)
              GestureDetector(
                onTap: RouteManagement.goToBack,
                child: Icon(
                  CupertinoIcons.arrow_left,
                  color: backBtnColor ??
                      Theme.of(context).textTheme.bodyLarge!.color,
                  size: Dimens.twentyFour,
                ),
              ),
            if (showBackBtn == true) Dimens.boxWidth16,
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (child != null) child!,
                  if (child != null && title != null) Dimens.boxWidth16,
                  if (title != null && title!.isNotEmpty)
                    Text(
                      title!,
                      style: titleStyle ??
                          AppStyles.style20Bold.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
