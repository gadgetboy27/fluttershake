import 'package:flutter/foundation.dart';

class Product {
  final int availableUnits;
  final double unitPrice;
  final bool approved;
  final String productName;
  final String productId;
  final String unitType;
  final String vendorId;
  final String imageUrl;
  final String note;

  Product(
      {@required this.productName,
      @required this.unitType,
      @required this.unitPrice,
      @required this.availableUnits,
      @required this.vendorId,
      @required this.productId,
      @required this.approved,
      this.imageUrl = '',
      this.note = ''});

  Map<String, dynamic> toMap() {
    return {
      'availableUnits': availableUnits,
      'productName': productName,
      'productId': productId,
      'vendorId': vendorId,
      'unitPrice': unitPrice,
      'unitType': unitType,
      'approved': approved,
      'imageUrl': imageUrl,
      'note': note,
    };
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : productName = firestore['productName'],
        unitPrice = firestore['unitPrice'],
        unitType = firestore['unitType'],
        availableUnits = firestore['availableUnits'],
        approved = firestore['approved'],
        imageUrl = firestore['imageUrl'],
        note = firestore['note'],
        productId = firestore['productId'],
        vendorId = firestore['vendorId'];
}
