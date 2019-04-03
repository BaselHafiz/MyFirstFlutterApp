import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_first_flutter_app/widgets/products/title_default.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;

  ProductPage(this.productIndex);

  Widget _buildAddressPriceRow(double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Fransisco |',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'cambria',
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Text(
            '\$ ${price.toString()}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'cambria',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Product product = model.allProducts[productIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(product.image),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TitleDefault(product.title),
                ),
                Container(
                  child: _buildAddressPriceRow(product.price),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cambria',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
