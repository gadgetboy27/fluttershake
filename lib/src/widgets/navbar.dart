import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:fluttershake/src/styles/text.dart';

abstract class AppNavBar {
  static CupertinoSliverNavigationBar cupertinoNavBar(
      {String title}) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title, style: TextStyles.navTitle),
      backgroundColor: Colors.transparent,
      border: null,
    );
  }

  static SliverAppBar materialNavBar(
      {@required String title, bool pinned,TabBar tabBar}) {
    return SliverAppBar(
        title: Text(title,style:TextStyles.navTitleMaterial),
        backgroundColor: AppColors.darkblue,
        bottom: tabBar,
        floating: true,
        pinned: (pinned==null)? true:pinned,
        snap: true,
    );
  }
}
