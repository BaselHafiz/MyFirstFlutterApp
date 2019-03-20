import 'package:flutter/material.dart';

import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> _products;

  ProductListPage(this._products);

  @override
  Widget build(BuildContext context) {
    if (_products.length > 0) {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
//              leading: Image.asset(_products[index]['image']),
              title: Text(_products[index]['title']),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return ProductEditPage(product: _products[index]);
                  }));
                },
              ),
            );
          },
          itemCount: _products.length);
    } else {
      return Center(child: Text("No products found, please add some"));
    }
  }
}
