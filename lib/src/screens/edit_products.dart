import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/blocs/auth_bloc.dart';
import 'package:fluttershake/src/blocs/product_bloc.dart';
import 'package:fluttershake/src/models/product.dart';
import 'package:fluttershake/src/styles/base.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:fluttershake/src/styles/text.dart';
import 'package:fluttershake/src/widgets/button.dart';
import 'package:fluttershake/src/widgets/dropdown_btn.dart';
import 'package:fluttershake/src/widgets/sliver_scaffold.dart';
import 'package:fluttershake/src/widgets/textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String productId;

  const EditProduct({Key key, this.productId}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  void initState() {
    var productBloc = Provider.of<ProductBloc>(context, listen: false);
    productBloc.productSaved.listen((saved) {
      if (saved != null && saved == true && context != null) {
        Fluttertoast.showToast(
            msg: "Product Saved",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColors.lightblue,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context).pop();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return FutureBuilder<Product>(
        future: productBloc.fetchProduct(widget.productId),
        builder: (context, snapshot) {
          if (!snapshot.hasData && widget.productId != null) {
            return Scaffold(
              body: Center(
                  child: (Platform.isIOS)
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator()),
            );
          }

          //Laod Bloc values into Edit Product page
          Product existingProduct;
          if (widget.productId != null) {
            //Edit Logic
            existingProduct = snapshot.data;
            loadValues(productBloc, existingProduct, authBloc.userId);
          } else {
            //Add Logic
            loadValues(productBloc, null, authBloc.userId);
          }

          return (Platform.isIOS)
              ? AppSliverScaffold.cupertinoSliverScaffold(
                  navTitle: '',
                  pageBody:
                      pageBody(true, productBloc, context, existingProduct),
                  context: context)
              : AppSliverScaffold.materialSliverScaffold(
                  navTitle: '',
                  pageBody:
                      pageBody(false, productBloc, context, existingProduct),
                  context: context);
        });
  }

  Widget pageBody(bool isIOS, ProductBloc productBloc, BuildContext context,
      Product existingProduct) {
    var items = Provider.of<List<String>>(context);
    var pageLabel = (existingProduct != null) ? 'Edit Product' : 'Add Product';
    return ListView(
      children: <Widget>[
        Text(
          pageLabel,
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
                initialText: (existingProduct != null)
                    ? existingProduct.productName
                    : null,
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
            }),
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
                initialText: (existingProduct != null)
                    ? existingProduct.unitPrice.toString()
                    : null,
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
                initialText: (existingProduct != null)
                    ? existingProduct.availableUnits.toString()
                    : null,
                onChanged: productBloc.changeAvailablUnits,
              );
            }),
        AppButton(buttonType: ButtonType.LightGray, buttonText: 'Add Image'),
        StreamBuilder<bool>(
            stream: productBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonType: (snapshot.data == true)
                    ? ButtonType.DarkBlue
                    : ButtonType.Disabled,
                buttonText: 'Save Product',
                onPressed: productBloc.saveProduct,
              );
            }),
      ],
    );
  }

  loadValues(ProductBloc productBloc, Product product, String vendorId) {
    productBloc.changeProduct(product);
    productBloc.changeVendorId(vendorId);

    if (product != null) {
      //Sets values in edit product from product
      productBloc.changeUnitType(product.unitType);
      productBloc.changeProductName(product.productName);
      productBloc.changeUnitPrice(product.unitPrice.toString());
      productBloc.changeAvailablUnits(product.availableUnits.toString());
    } else {
      //Resets add Product page values to null
      productBloc.changeUnitType(null);
      productBloc.changeProductName(null);
      productBloc.changeUnitPrice(null);
      productBloc.changeAvailablUnits(null);
    }
  }
}
