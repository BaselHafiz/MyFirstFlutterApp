import 'package:flutter/material.dart';

import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> _products;

  ProductsPage(this._products);

  Widget _buildSideDrawer(BuildContext context){
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Manage products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/adminPage');
            },
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          ),
        ],
      ),
      body: Products(_products),
    );
  }
}