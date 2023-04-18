import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/assets.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/asset_image.dart';
import 'package:social_media_app/global_widgets/avatar_widget.dart';
import 'package:social_media_app/global_widgets/circular_progress_indicator.dart';
import 'package:social_media_app/global_widgets/custom_list_tile.dart';
import 'package:social_media_app/global_widgets/custom_refresh_indicator.dart';
import 'package:social_media_app/global_widgets/load_more_widget.dart';
import 'package:social_media_app/global_widgets/primary_icon_btn.dart';
import 'package:social_media_app/global_widgets/sliver_app_bar.dart';
import 'package:social_media_app/modules/home/controllers/banner_controller.dart';
import 'package:social_media_app/modules/home/controllers/post_controller.dart';
import 'package:social_media_app/modules/home/controllers/profile_controller.dart';
import 'package:social_media_app/modules/home/views/components/post_widget.dart';
import 'package:social_media_app/routes/route_management.dart';
import 'package:social_media_app/utils/utility.dart';

class HomeTabView extends StatelessWidget {
  const HomeTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: Dimens.screenWidth,
      height: Dimens.screenHeight,
      child: NxRefreshIndicator(
        onRefresh: () => PostController.find.fetchPosts(),
        showProgress: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            _buildAppBar(context),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  AyushSliverAppBar _buildAppBar(BuildContext context) {
    return AyushSliverAppBar(
      padding: Dimens.edgeInsetsDefault,
      height: Dimens.fourtyEight,
      leading: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AyushAssetImage(
              imgAsset: AssetValues.appIcon,
              width: Dimens.twentyFour,
              height: Dimens.twentyFour,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _showCreatePostOptions(context),
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    size: Dimens.thirtyTwo,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
                Dimens.boxWidth12,
                GestureDetector(
                  onTap: RouteManagement.goToProfileView,
                  child: GetBuilder<ProfileController>(
                    builder: (logic) {
                      if (logic.profileDetails == null ||
                          logic.profileDetails!.user == null ||
                          logic.profileDetails!.user!.avatar == null ||
                          logic.profileDetails!.user!.avatar!.url == null) {
                        return Hero(
                          tag: logic.profileDetails!.user!.id,
                          child: AvatarWidget(
                            avatar: logic.profileDetails!.user!.avatar,
                            size: Dimens.sixTeen,
                          ),
                        );
                      }
                      return Hero(
                        tag: logic.profileDetails!.user!.id,
                        child: AvatarWidget(
                          avatar: logic.profileDetails!.user!.avatar!,
                          size: Dimens.sixTeen,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GetBuilder<PostController>(
      builder: (logic) {
        if (logic.isLoading &&
            (logic.postData == null || logic.postList.isEmpty)) {
          return const SliverFillRemaining(
            child: Center(child: AyushCircularProgressIndicator()),
          );
        }

        if (logic.postData == null || logic.postList.isEmpty) {
          return SliverFillRemaining(
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    StringValues.noPosts,
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

        return SliverToBoxAdapter(
          child: Padding(
            padding: Dimens.edgeInsetsHorizDefault,
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                if (logic.isLoading &&
                    (logic.postData != null || logic.postList.isNotEmpty))
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Dimens.boxHeight8,
                      const AyushCircularProgressIndicator(),
                      Dimens.boxHeight8,
                    ],
                  ),
                _buildBanner(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: logic.postList.length,
                  itemBuilder: (context, index) {
                    final post = logic.postList[index];
                    return PostWidget(
                      post: post,
                      controller: logic,
                    );
                  },
                ),
                LoadMoreWidget(
                  loadingCondition: logic.isMoreLoading,
                  hasMoreCondition: logic.postData!.results != null &&
                      logic.postData!.hasNextPage!,
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

  void _showCreatePostOptions(BuildContext context) =>
      AppUtility.showBottomSheet(
        children: [
          /// Post
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            leading: Icon(
              Icons.post_add_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            title: Text(
              StringValues.post,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.goToCreatePostView();
            },
          ),

          /// Poll
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            leading: Icon(
              Icons.poll_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            title: Text(
              StringValues.poll,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              RouteManagement.toCreatePollView();
            },
          ),

          /// Story
          NxListTile(
            bgColor: ColorValues.transparent,
            padding: Dimens.edgeInsets12,
            showBorder: false,
            leading: Icon(
              Icons.photo_library_outlined,
              size: Dimens.twentyFour,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            title: Text(
              StringValues.story,
              style: AppStyles.style16Normal.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            onTap: () {
              AppUtility.closeBottomSheet();
              AppUtility.printLog('Go to create story page');
            },
          ),
        ],
      );

  Widget _buildBanner() {
    var currentItem = 0;
    return GetBuilder<BannerController>(
      builder: (bannerLogic) {
        if (bannerLogic.bannerList.isNotEmpty) {
          return StatefulBuilder(
            builder: (context, setInnerState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FlutterCarousel(
                    items: bannerLogic.bannerList
                        .map((media) => Container(
                              width: Dimens.screenWidth,
                              padding: Dimens.edgeInsets8,
                              decoration: const BoxDecoration(
                                color: ColorValues.primaryColor,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        text: media,
                                        style: AppStyles.style13Normal.copyWith(
                                          color: ColorValues.whiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Dimens.boxWidth2,
                                  AyushIconButton(
                                    icon: Icons.clear_outlined,
                                    onTap: () =>
                                        bannerLogic.deleteBanner(currentItem),
                                    iconColor: ColorValues.whiteColor,
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                    options: CarouselOptions(
                        height: Dimens.eighty,
                        viewportFraction: 1.0,
                        showIndicator: false,
                        onPageChanged: (int index, reason) {
                          setInnerState(() {
                            currentItem = index;
                          });
                        }),
                  ),
                  if (bannerLogic.bannerList.length > 1) Dimens.boxHeight4,
                  if (bannerLogic.bannerList.length > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: bannerLogic.bannerList.asMap().entries.map(
                        (entry) {
                          return Container(
                            width: Dimens.eight,
                            height: Dimens.eight,
                            margin: EdgeInsets.symmetric(
                              horizontal: Dimens.two,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? ColorValues.whiteColor
                                      : ColorValues.blackColor)
                                  .withOpacity(
                                      currentItem == entry.key ? 0.9 : 0.4),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                ],
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
