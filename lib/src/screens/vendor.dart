import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/widgets/vendor_scaffold.dart';
import 'dart:io';
import 'package:fluttershake/src/widgets/navbar.dart';

class Vendor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                AppNavBar.cupertinoNavBar(
                    title: 'Vendor Name', context: context),
              ];
            },
            body: VendorScaffold.cupertinoTabScaffold),
      );
    } else {
      return Center(
          child: Scaffold(
        body: Text('Material'),
      ));
    }
  }
}
