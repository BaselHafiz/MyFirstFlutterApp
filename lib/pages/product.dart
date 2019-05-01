import 'package:flutter/material.dart';
import 'dart:async';

import 'package:my_first_flutter_app/widgets/products/title_default.dart';
import '../models/product.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  Widget _buildAddressPriceRow(String address, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          address,
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
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FadeInImage(
              image: NetworkImage(product.image),
              height: 300,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/food.jpg'),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TitleDefault(product.title),
            ),
            Container(
              child: _buildAddressPriceRow(product.location.address, product.price),
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
      ),
    );
  }
}
