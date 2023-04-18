import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/modules/follow_request/follow_request_controller.dart';
import 'package:social_media_app/modules/home/controllers/notification_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/components/notification_widget.dart';
import 'package:social_media_app/routes/route_management.dart';

class NotificationTabView extends StatelessWidget {
  const NotificationTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      width: Dimens.screenWidth,
      height: Dimens.screenHeight,
      child: NxRefreshIndicator(
        onRefresh: NotificationController.find.getNotifications,
        showProgress: false,
        triggerMode: NxRefreshIndicatorTriggerMode.anywhere,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AyushAppBar(
              title: StringValues.notifications,
              padding: Dimens.edgeInsetsDefault,
              showBackBtn: false,
            ),
            _buildBody(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final profile = ProfileController.find.profileDetails!.user!;

    return GetBuilder<NotificationController>(
      builder: (logic) {
        if (logic.isLoading &&
            (logic.notificationData == null ||
                logic.notificationList.isEmpty)) {
          return const Expanded(
            child: Center(child: AyushCircularProgressIndicator()),
          );
        }

        if (logic.notificationData == null || logic.notificationList.isEmpty) {
          return Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: Dimens.edgeInsetsHorizDefault,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Dimens.heightedBox(Dimens.screenHeight * 0.25),
                  Text(
                    StringValues.noNotifications,
                    style: AppStyles.style32Bold.copyWith(
                      color:
                          Theme.of(Get.context!).textTheme.titleMedium!.color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Dimens.boxHeight16,
                ],
              ),
            ),
          );
        }

        return Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: Dimens.edgeInsetsHorizDefault,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (logic.isLoading &&
                    (logic.notificationData != null ||
                        logic.notificationList.isNotEmpty))
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Dimens.boxHeight8,
                      const AyushCircularProgressIndicator(),
                    ],
                  ),
                if (profile.isPrivate) Dimens.boxHeight8,
                if (profile.isPrivate) _buildFollowRequestBtn(context),
                if (profile.isPrivate) Dimens.boxHeight8,
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: logic.notificationList.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    var item = logic.notificationList[index];

                    return NotificationWidget(
                      notification: item,
                      totalLength: logic.notificationList.length,
                      index: index,
                    );
                  },
                ),
                LoadMoreWidget(
                  loadingCondition: logic.isMoreLoading,
                  hasMoreCondition: logic.notificationData!.results != null &&
                      logic.notificationData!.hasNextPage!,
                  loadMore: logic.loadMore,
                ),
                Dimens.boxHeight16,
              ],
            ),
          ),
        );
      },
    );
  }

  GetBuilder<FollowRequestController> _buildFollowRequestBtn(
      BuildContext context) {
    return GetBuilder<FollowRequestController>(
      builder: (logic) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: RouteManagement.goToFollowRequestsView,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: Dimens.edgeInsets12,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: Dimens.one,
                            ),
                          ),
                          child: Icon(
                            Icons.person_add_alt,
                            size: Dimens.twentyFour,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        Dimens.boxWidth8,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              StringValues.followRequests,
                              style: AppStyles.style14Bold.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color,
                              ),
                            ),
                            Dimens.boxHeight2,
                            Text(StringValues.followRequestsDesc,
                                style: AppStyles.style13Normal.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .color,
                                )),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      logic.followRequestList.length.toString(),
                      style: AppStyles.style14Bold.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
