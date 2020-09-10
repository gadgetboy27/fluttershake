import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/blocs/product_bloc.dart';
import 'package:fluttershake/src/styles/base.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:fluttershake/src/styles/text.dart';
import 'package:fluttershake/src/widgets/button.dart';
import 'package:fluttershake/src/widgets/dropdown_btn.dart';
import 'package:fluttershake/src/widgets/sliver_scaffold.dart';
import 'package:fluttershake/src/widgets/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    if (Platform.isIOS) {
      return AppSliverScaffold.cupertinoSliverScaffold(
          navTitle: '',
          pageBody: pageBody(true, productBloc, context),
          context: context);
    } else {
      return AppSliverScaffold.materialSliverScaffold(
          navTitle: '',
          pageBody: pageBody(false, productBloc, context),
          context: context);
    }
  }

  Widget pageBody(bool isIOS, ProductBloc productBloc, BuildContext context) {
    var items = Provider.of<List<String>>(context);
    return ListView(
      children: <Widget>[
        Text(
          'Add Product',
          style: TextStyles.subtitle,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: Divider(
            color: AppColors.darkblue,
          ),
        ),
        StreamBuilder<String>(
            stream: productBloc.productName,
            builder: (context, snapshot) {
              return AppTextField(
                hintText: 'Product Name',
                cupertinoIcon: FontAwesomeIcons.shoppingBasket,
                materialIcon: FontAwesomeIcons.shoppingBasket,
                isIOS: isIOS,
                errorText: snapshot.error,
                onChanged: productBloc.changeProductName,
              );
            }),
        StreamBuilder<String>(
          stream: productBloc.unitType,
          builder: (context, snapshot) {
            return AppDropdownButton(
              hintText: 'Unit Type',
              items: items,
              value: snapshot.data,
              onChanged: productBloc.changeUnitType,
              materialIcon: FontAwesomeIcons.balanceScale,
              cupertinoIcon: FontAwesomeIcons.balanceScale,
            );
          }
        ),
        StreamBuilder<double>(
            stream: productBloc.unitPrice,
            builder: (context, snapshot) {
              return AppTextField(
                hintText: 'Unit Price',
                cupertinoIcon: FontAwesomeIcons.tag,
                materialIcon: FontAwesomeIcons.tag,
                isIOS: isIOS,
                textInputType: TextInputType.number,
                errorText: snapshot.error,
                onChanged: productBloc.changeUnitPrice,
              );
            }),
        StreamBuilder<int>(
            stream: productBloc.availableUnits,
            builder: (context, snapshot) {
              return AppTextField(
                hintText: 'Available Units',
                cupertinoIcon: FontAwesomeIcons.cubes,
                materialIcon: FontAwesomeIcons.cubes,
                isIOS: isIOS,
                textInputType: TextInputType.number,
                errorText: snapshot.error,
                onChanged: productBloc.changeAvailablUnits,
              );
            }),
        AppButton(buttonType: ButtonType.LightGray, buttonText: 'Add Image'),
        StreamBuilder<bool>(
          stream: productBloc.isValid,
          builder: (context, snapshot) {
            return AppButton(
              buttonType: (snapshot.data==true)?ButtonType.DarkBlue:ButtonType.Disabled, 
              buttonText: 'Save Product',
              );
          }
        ),
      ],
    );
  }
}
