
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/screens/edit_products.dart';
import 'package:fluttershake/src/screens/landing.dart';
import 'package:fluttershake/src/screens/login.dart';
import 'package:fluttershake/src/screens/signup.dart';
import 'package:fluttershake/src/screens/vendor.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(builder: (context) => Landing());
      case '/signup':
        return MaterialPageRoute(builder: (context) => Signup());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/vendor':
        return MaterialPageRoute(builder: (context) => Vendor());
      case '/editproduct':
        return MaterialPageRoute(builder: (context) => EditProduct());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editproduct/')) {
          return MaterialPageRoute(
              builder: (context) => EditProduct(
                    productId: routeArray[2],
                  ));
        }
        return MaterialPageRoute(builder: (context) => Landing());
    }
  }

  static CupertinoPageRoute cupertinoRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return CupertinoPageRoute(builder: (context) => Landing());
      case '/signup':
        return CupertinoPageRoute(builder: (context) => Signup());
      case '/login':
        return CupertinoPageRoute(builder: (context) => Login());
      case '/vendor':
        return CupertinoPageRoute(builder: (context) => Vendor());
      case '/editproduct':
        return CupertinoPageRoute(builder: (context) => EditProduct());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/editproduct/')) {
          return CupertinoPageRoute(
              builder: (context) => EditProduct(
                    productId: routeArray[2],
                  ));
        }
        return CupertinoPageRoute(builder: (context) => Landing());
    }
  }
}
