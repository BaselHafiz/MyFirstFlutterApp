import 'package:flutter/material.dart';

import 'price_tag.dart';

class ProductCard extends StatelessWidget{
  final Map<String, dynamic> product;
  final int productIndex;


  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product['image']),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  product['title'],
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cambria',
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                PriceTag(product['price'].toString()),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            margin: EdgeInsets.only(top: 7),
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text('Union Square, San Fransisco'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>(
                  context,
                  '/product/' + productIndex.toString(),
                ),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}