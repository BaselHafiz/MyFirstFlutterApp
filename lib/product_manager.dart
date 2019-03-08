import 'package:flutter/material.dart';

import './products.dart';
import './product_control.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> _products;
  final Function deleteProduct;
  final Function addProduct;

  ProductManager(this._products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5),
          // Pass the function '_addProduct' to execute 'SetState' inside of
          // the statelessWidget
          child: ProductControl(addProduct),
        ),
        Expanded(
          child: Products(_products, deleteProduct: deleteProduct),
        )
      ],
    );
  }
}
