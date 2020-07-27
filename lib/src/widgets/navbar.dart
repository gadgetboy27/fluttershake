import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/text.dart';

abstract class AppNavBar {
  static CupertinoSliverNavigationBar cupertinoNavBar(
      {String title, BuildContext context}) {
    return CupertinoSliverNavigationBar(
      largeTitle: Text(title,style:TextStyles.navTitle),
      backgroundColor: Colors.transparent,
      border:null,
    );
  }
}
