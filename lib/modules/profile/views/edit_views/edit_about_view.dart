import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/colors.dart';
import 'package:social_media_app/constants/dimens.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/custom_app_bar.dart';
import 'package:social_media_app/global_widgets/primary_filled_btn.dart';
import 'package:social_media_app/modules/profile/controllers/edit_about_controller.dart';

class EditAboutView extends StatelessWidget {
  const EditAboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: Dimens.screenWidth,
            height: Dimens.screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AyushAppBar(
                  title: StringValues.about,
                  padding: Dimens.edgeInsetsDefault,
                ),
                _buildBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() => GetBuilder<EditAboutController>(
        builder: (logic) => Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: Dimens.edgeInsetsHorizDefault,
              child: FocusScope(
                node: logic.focusNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Dimens.boxHeight8,
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: Dimens.screenWidth,
                        minHeight: Dimens.fiftySix,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: StringValues.writeSomethingAboutYou,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimens.four),
                          ),
                          hintStyle: AppStyles.style14Normal.copyWith(
                            color: ColorValues.grayColor,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        style: AppStyles.style14Normal.copyWith(
                          color:
                              Theme.of(Get.context!).textTheme.bodyLarge!.color,
                        ),
                        controller: logic.aboutTextController,
                        onEditingComplete: logic.focusNode.unfocus,
                      ),
                    ),
                    Dimens.boxHeight40,
                    AyushFilledButton(
                      onTap: logic.updateAbout,
                      label: StringValues.save.toUpperCase(),
                      height: Dimens.fiftySix,
                    ),
                    Dimens.boxHeight16,
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
