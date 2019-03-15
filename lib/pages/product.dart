import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/title_default.dart';

class ProductPage extends StatelessWidget {
  final String image, title, description;
  final double price;

  ProductPage(this.title, this.image, this.description, this.price);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(image),
            Container(
              padding: EdgeInsets.all(10),
              child: TitleDefault(title),
            ),
            Container(
              child: Row(
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
              ),
            ),
            Text(
              description,
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
