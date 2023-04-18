import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/extensions/string_extensions.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/custom_radio_tile.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';

class OnlineStatusView extends StatelessWidget {
  const OnlineStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: Dimens.screenWidth,
          height: Dimens.screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AyushAppBar(
                title: StringValues.onlineStatus,
                padding: Dimens.edgeInsetsDefault,
              ),
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: Dimens.edgeInsetsHorizDefault,
        child: SingleChildScrollView(
          child: GetBuilder<ProfileController>(
            builder: (logic) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Dimens.boxHeight8,

                /// Public
                NxRadioTile(
                  padding: Dimens.edgeInsets12,
                  bgColor: Theme.of(context).cardColor,
                  showBorder: true,
                  borderRadius: BorderRadius.circular(Dimens.four),
                  onTap: () {
                    var body = {'showOnlineStatus': 'true'};
                    logic.updateProfile(
                      body,
                      showLoading: true,
                    );
                  },
                  onChanged: (v) {
                    var body = {'showOnlineStatus': '$v'};
                    logic.updateProfile(
                      body,
                      showLoading: true,
                    );
                  },
                  title: Text(
                    StringValues.on.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.onlineStatusOnDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                  value: true,
                  groupValue: ProfileController
                      .find.profileDetails!.user!.showOnlineStatus,
                ),

                Dimens.boxHeight8,

                /// Private
                NxRadioTile(
                  padding: Dimens.edgeInsets12,
                  bgColor: Theme.of(context).cardColor,
                  showBorder: true,
                  borderRadius: BorderRadius.circular(Dimens.four),
                  onTap: () {
                    var body = {'showOnlineStatus': 'false'};
                    logic.updateProfile(
                      body,
                      showLoading: true,
                    );
                  },
                  onChanged: (v) {
                    var body = {'showOnlineStatus': '$v'};
                    logic.updateProfile(
                      body,
                      showLoading: true,
                    );
                  },
                  title: Text(
                    StringValues.off.toTitleCase(),
                    style: AppStyles.style14Bold,
                  ),
                  subtitle: Text(
                    StringValues.onlineStatusOffDesc,
                    style: AppStyles.style13Normal.copyWith(
                      color: Theme.of(context).textTheme.titleMedium!.color,
                    ),
                  ),
                  value: false,
                  groupValue: ProfileController
                      .find.profileDetails!.user!.showOnlineStatus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
