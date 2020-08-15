import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttershake/src/blocs/auth_bloc.dart';
import 'package:fluttershake/src/blocs/product_bloc.dart';
import 'package:fluttershake/src/screens/login.dart';
import 'package:fluttershake/src/routes.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:fluttershake/src/styles/text.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'screens/landing.dart';

final authBloc = AuthBloc();
final productBloc = ProductBloc();

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context) => authBloc),
      Provider(create: (context) => productBloc),
      FutureProvider(create: (context) => authBloc.isLoggedIn())
    ], child: PlatformApp());
  }

  @override
  void dispose() {
    authBloc.dispose();
    productBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
          home: (isLoggedIn == null)
              ? loadingScreen(true)
              : (isLoggedIn == true) ? Landing() : Login(),
          onGenerateRoute: Routes.cupertinoRoutes,
          theme: CupertinoThemeData(
              primaryColor: AppColors.straw,
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                  tabLabelTextStyle: TextStyles.suggestion)));
    } else {
      return MaterialApp(
          home: (isLoggedIn == null)
              ? loadingScreen(false)
              : (isLoggedIn == true) ? Landing() : Login(),
          onGenerateRoute: Routes.materialRoutes,
          theme: ThemeData(scaffoldBackgroundColor: Colors.white));
    }
  }

  Widget loadingScreen(bool isIOS) {
    return (isIOS)
        ? CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(),
            ),
          )
        : Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
