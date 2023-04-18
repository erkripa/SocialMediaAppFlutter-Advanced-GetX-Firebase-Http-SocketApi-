import 'package:flutter/material.dart';
import 'package:social_media_app/apis/models/entities/poll_option.dart';
import 'package:social_media_app/apis/models/entities/post.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/modules/post/views/widgets/linear_progress_painter.dart';

class PollOptionWidget extends StatelessWidget {
  const PollOptionWidget({
    super.key,
    required this.option,
    required this.isExpired,
    this.greatestPercentageId,
    required this.onTap,
    required this.post,
  });

  final Post post;
  final PollOption option;
  final bool isExpired;
  final String? greatestPercentageId;
  final VoidCallback onTap;

  Color _buildPollColor(Post post, bool isExpired, PollOption option,
      String? greatestPercentageId, BuildContext context) {
    if (isExpired) {
      if (greatestPercentageId != null && option.id == greatestPercentageId) {
        return ColorValues.primaryColor;
      }
      return Theme.of(context).disabledColor;
    } else if (post.isVoted == true) {
      return Theme.of(context).disabledColor;
    }

    return ColorValues.transparent;
  }

  Color _buildPollBorderColor(Post post, bool isExpired, PollOption option,
      String? greatestPercentageId, BuildContext context) {
    if (isExpired || post.isVoted == true) {
      return Theme.of(context).disabledColor;
    }

    return ColorValues.linkColor;
  }

  @override
  Widget build(BuildContext context) {
    final percentage =
        post.totalVotes! > 0 ? option.votes! / post.totalVotes! : 0.0;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: Dimens.edgeInsets4_8,
        child: CustomPaint(
          painter: LinearProgressPainter(
            valueColor: _buildPollColor(
                post, isExpired, option, greatestPercentageId, context),
            value: percentage,
            textDirection: Directionality.of(context),
            borderColor: _buildPollBorderColor(
                post, isExpired, option, greatestPercentageId, context),
            borderRadius: Dimens.four,
            borderWidth: Dimens.pointFour,
          ),
          child: Container(
            width: double.infinity,
            padding: Dimens.edgeInsets8_12,
            decoration: BoxDecoration(
              color: ColorValues.transparent,
              borderRadius: BorderRadius.circular(Dimens.four),
            ),
            child: Row(
              mainAxisAlignment: (isExpired || post.isVoted == true)
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
                    mainAxisAlignment: (isExpired || post.isVoted == true)
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          option.option!,
                          style: AppStyles.style13Normal.copyWith(
                            color: !isExpired && post.isVoted == false
                                ? ColorValues.linkColor
                                : Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                      ),
                      if (post.isVoted == true && option.id == post.votedOption)
                        Dimens.boxWidth4,
                      if (post.isVoted == true && option.id == post.votedOption)
                        Icon(
                          Icons.check_circle_outline,
                          size: Dimens.sixTeen,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                    ],
                  ),
                ),
                if (isExpired || post.isVoted == true) Dimens.boxWidth4,
                if (isExpired || post.isVoted == true)
                  Text(
                    '${(percentage * 100).toStringAsFixed(0)}%',
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
