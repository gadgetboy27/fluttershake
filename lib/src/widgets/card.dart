import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/base.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:fluttershake/src/styles/text.dart';
import 'package:intl/intl.dart';

class AppCard extends StatelessWidget {
  final String productName;
  final String unitType;
  final String note;
  final double price;
  final int availableUnits;

  final formatCurrency = NumberFormat.simpleCurrency();

  AppCard(
      {Key key,
      this.productName,
      this.unitType,
      this.note = '',
      this.price,
      this.availableUnits})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: BaseStyles.listPadding,
      padding: BaseStyles.listPadding,
      decoration: BoxDecoration(
          boxShadow: BaseStyles.boxShadow,
          color: Colors.white,
          border: Border.all(
            color: AppColors.darkblue,
            width: BaseStyles.borderWidth,
          ),
          borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
          ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset(
                'assets/images/aji.jpeg',
                height: 50.0,
              ),
              Column(
                children: <Widget>[
                  Text(productName),
                  Text('${formatCurrency.format(price)}/$unitType'),
                  (availableUnits > 0) ? Text('Avalable') : Text('Not in Stock')
                ],
              )
            ],
          ),
          Text(
            note,
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }
}
