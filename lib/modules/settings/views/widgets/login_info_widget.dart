import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:social_media_app/apis/models/entities/login_info.dart';
import 'package:social_media_app/app_services/auth_service.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/modules/settings/controllers/login_info_controller.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class LoginInfoWidget extends StatelessWidget {
  const LoginInfoWidget({
    Key? key,
    required this.item,
    this.margin,
  }) : super(key: key);

  final LoginInfo item;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => AppUtility.showDeleteDialog(
        context,
        () async {
          AppUtility.closeDialog();
          if (item.deviceId! == AuthService.find.deviceId.toString()) {
            await AuthService.find.logout();
            RouteManagement.goToWelcomeView();
            return;
          } else {
            await LoginInfoController.find
                .deleteLoginDeviceInfo(item.deviceId!);
          }
        },
      ),
      child: Container(
        margin: Dimens.edgeInsets8_0,
        padding: Dimens.edgeInsets8,
        constraints: BoxConstraints(
          maxWidth: Dimens.screenWidth,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimens.four),
          boxShadow: AppStyles.defaultShadow,
        ),
        child: NxListTile(
          padding: Dimens.edgeInsets0,
          bgColor: ColorValues.transparent,
          showBorder: false,
          leading: item.deviceType == 'android'
              ? CircleAvatar(
                  backgroundColor: ColorValues.grayColor,
                  radius: Dimens.twentyFour,
                  child: Icon(
                    Icons.phone_android,
                    size: Dimens.thirtyTwo,
                    color: ColorValues.darkerGrayColor,
                  ),
                )
              : CircleAvatar(
                  backgroundColor: ColorValues.grayColor,
                  radius: Dimens.twentyFour,
                  child: Icon(
                    Icons.phone_iphone,
                    size: Dimens.thirtyTwo,
                    color: ColorValues.darkerGrayColor,
                  ),
                ),
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: item.deviceModel!,
                  style: AppStyles.style14Bold.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                if (item.deviceId == AuthService.find.deviceId.toString())
                  TextSpan(
                    text: "  •",
                    style: AppStyles.style14Bold.copyWith(
                      color: ColorValues.successColor,
                    ),
                  ),
              ],
            ),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: "${item.city!}, ${item.regionName!}, ${item.country!}",
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: GetTimeAgo.parse(
                    item.createdAt!.toLocal(),
                    pattern: 'dd MMM yyyy hh:mm a',
                  ),
                  style: AppStyles.style13Normal.copyWith(
                    color: Theme.of(context).textTheme.titleMedium!.color,
                  ),
                ),
              ),
            ],
          ),
          trailingFlex: 0,
          trailing: GestureDetector(
            onTap: () => _showDeleteDialog(item.deviceId!, context),
            child: Icon(
              Icons.close,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteDialog(String deviceId, BuildContext context) async {
    AppUtility.showDeleteDialog(
      context,
      () async {
        AppUtility.closeDialog();
        if (deviceId == AuthService.find.deviceId.toString()) {
          await AuthService.find.logout();
          RouteManagement.goToWelcomeView();
          return;
        } else {
          await LoginInfoController.find.deleteLoginDeviceInfo(deviceId);
        }
      },
    );
  }
}
