import 'package:flutter/material.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/primary_text_btn.dart';

class LoadMoreWidget extends StatelessWidget {
  const LoadMoreWidget({
    super.key,
    required this.loadingCondition,
    required this.hasMoreCondition,
    required this.loadMore,
  });

  final bool loadingCondition;
  final bool hasMoreCondition;
  final VoidCallback loadMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Dimens.boxHeight8,
        if (loadingCondition)
          const Center(child: AyushCircularProgressIndicator()),
        if (!loadingCondition && hasMoreCondition)
          Center(
            child: AyushTextButton(
              label: StringValues.loadMore,
              onTap: loadMore,
              labelStyle: AppStyles.style14Bold.copyWith(
                color: ColorValues.linkColor,
              ),
              padding: Dimens.edgeInsets8_0,
            ),
          ),
      ],
    );
  }
}
