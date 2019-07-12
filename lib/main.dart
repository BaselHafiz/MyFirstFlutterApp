import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/models/product.dart';
import './pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';
import './scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:map_view/map_view.dart';
import './widgets/helpers/custom_route.dart';
import 'shared/global_config.dart';
import './shared/adaptive_theme.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  MapView.setApiKey(apiKey);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _mainModel = MainModel();
  final _platformChannel = MethodChannel('flutter-battery');
  bool _isAuthenticated = false;


  Future<Null> _getBatteryLevelOfMyEmulator() async {
    String batteryLevel;
    try {
      final int result = await _platformChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level is $result %.';
    } catch (error) {
      batteryLevel = 'Failed to get battery level.';
      print(error);
    }
    print(batteryLevel);
  }

  @override
  void initState() {
    _mainModel.autoAuthenticate();
    _mainModel.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    _getBatteryLevelOfMyEmulator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _mainModel,
      child: MaterialApp(
        theme: getAdaptiveThemeData(context),
        routes: {
          '/': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsPage(_mainModel),
          '/adminPage': (BuildContext context) =>
              !_isAuthenticated ? AuthPage() : ProductsAdminPage(_mainModel)
        },
        onGenerateRoute: (RouteSettings settings) {
          if (!_isAuthenticated) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => AuthPage(),
            );
          }

          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'product') {
            final String productId = pathElements[2];
            final Product product =
                _mainModel.allProducts.firstWhere((Product product) {
              return product.id == productId;
            });
            return CustomRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductPage(product),
            );
          }
          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
              builder: (BuildContext context) => ProductsPage(_mainModel));
        },
      ),
    );
  }
}
