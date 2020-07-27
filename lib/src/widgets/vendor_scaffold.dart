import 'package:flutter/cupertino.dart';
import 'package:fluttershake/src/styles/colors.dart';

import 'orders.dart';
import 'products.dart';
import 'profile.dart';

abstract class VendorScaffold {
  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold(
        tabBar: _cupertinoTabBar,
        tabBuilder: (context, index) {
          return _pageSelection(index);
        });
  }

  static get _cupertinoTabBar {
    return CupertinoTabBar(
        backgroundColor: AppColors.darkgray,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.create), title: Text('Products')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.shopping_cart), title: Text('Orders')),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), title: Text('Profile')),
        ]);
  }

  static Widget _pageSelection(int index) {
    if (index == 0) {
      return Products();
    }

    if (index == 1) {
      return Orders();
    }

    return Profile();
  }
}
