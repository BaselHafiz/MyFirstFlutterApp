import 'package:flutter/material.dart';

import 'product_edit.dart';
import '../scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditPage();
        }));
      },
    );
  }

  Widget _buildProductList(MainModel model) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.products[index].title),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart ||
                  direction == DismissDirection.startToEnd) {
                model.selectProduct(index);
                model.deleteProduct();
              }
            },
            background: Container(color: Colors.deepOrange),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage(model.allProducts[index].image)),
                  title: Text(model.allProducts[index].title),
                  subtitle:
                      Text('\$ ${model.allProducts[index].price.toString()}'),
                  trailing: _buildEditButton(context, index, model),
                ),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.products.length);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        if (model.allProducts.length > 0) {
          return _buildProductList(model);
        } else {
          return Center(child: Text("No products found, please add some"));
        }
      },
    );
  }
}
