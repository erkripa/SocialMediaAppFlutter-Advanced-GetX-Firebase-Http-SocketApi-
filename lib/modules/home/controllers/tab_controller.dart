import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constants/strings.dart';
import 'package:social_media_app/constants/styles.dart';
import 'package:social_media_app/global_widgets/keep_alive_page.dart';
import 'package:social_media_app/modules/home/views/trending_tabs/people_tab.dart';
import 'package:social_media_app/modules/home/views/trending_tabs/trending_posts_tab.dart';

class TrendingTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static TrendingTabController get find => Get.find();

  TabController? _controller;
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  TabController get controller => _controller!;

  @override
  void onInit() {
    super.onInit();
    _controller = TabController(length: tabs.length, vsync: this);
    _controller?.addListener(() {
      _selectedIndex = _controller!.index;
      update();
    });
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }

  final tabViews = const [
    KeepAlivePage(child: TrendingPostsTab()),
    KeepAlivePage(child: PeopleTab()),
  ];

  List<Widget> tabs = [
    Tab(child: Text(StringValues.trending, style: AppStyles.style14Bold)),
    Tab(child: Text(StringValues.people, style: AppStyles.style14Bold)),
  ];
}
