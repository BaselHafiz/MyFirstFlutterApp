import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
        children:
            products // Use products.map to convert the elements of _products into a list of Card widgets
                .map((element) => Card(
                      // element is a string, because _products is a list of strings
                      child: Column(
                        children: <Widget>[
                          Image.asset('assets/food.jpg'),
                          Text(element)
                        ],
                      ),
                    ))
                .toList());
  }
}
