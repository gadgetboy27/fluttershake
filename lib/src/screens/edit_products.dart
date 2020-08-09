import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttershake/src/widgets/sliver_scaffold.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct>{
  @override
  Widget build(BuildContext context){
    if (Platform.isIOS){
      return AppSliverScaffold.cupertinoSliverScaffold(
          navTitle: '', pageBody: pageBody(), context: context);
    } else{
      return AppSliverScaffold.materialSliverScaffold(
          navTitle: '', pageBody: pageBody(), context: context);
    }
  }

  Widget pageBody(){
    return Container();
  }
}
