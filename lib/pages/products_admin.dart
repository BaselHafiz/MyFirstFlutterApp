import 'package:flutter/material.dart';
import './product_edit.dart';
import './product_list.dart';
import '../scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/products/logout_list_tile.dart';

class ProductsAdminPage extends StatelessWidget {
  final MainModel mainModel;

  ProductsAdminPage(this.mainModel);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("All products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/productsPage');
            },
          ),
          Divider(height: 5),
          LogoutListTile(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: _buildSideDrawer(context),
        appBar: AppBar(
          title: Text('Manage Products'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(
                icon: Icon(Icons.list),
                text: 'My Products',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ProductEditPage(),
            ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
                if (model.allProducts.length > 0) {
                  return ProductListPage(mainModel);
                } else {
                  return Center(child: Text('No products found !'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
