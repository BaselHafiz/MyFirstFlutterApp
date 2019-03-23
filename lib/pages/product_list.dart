import 'package:flutter/material.dart';

import 'product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> _products;
  final Function updateProduct, deleteProduct;

  ProductListPage(this._products, this.updateProduct, this.deleteProduct);

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditPage(
            product: _products[index],
            updateProduct: updateProduct,
            productIndex: index,
          );
        }));
      },
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_products[index]['title']),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart ||
                  direction == DismissDirection.startToEnd) {
                deleteProduct(index);
              }
            },
            background: Container(color: Colors.deepOrange),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(_products[index]['image'])),
                  title: Text(_products[index]['title']),
                  subtitle: Text('\$ ${_products[index]['price'].toString()}'),
                  trailing: _buildEditButton(context, index),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: _products.length);
  }

  @override
  Widget build(BuildContext context) {
    if (_products.length > 0) {
      return _buildProductList();
    } else {
      return Center(child: Text("No products found, please add some"));
    }
  }
}
