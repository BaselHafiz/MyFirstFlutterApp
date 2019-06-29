import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scoped_models/main.dart';

class ProductFab extends StatefulWidget {
  final Product product;

  ProductFab(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductFabState();
  }
}

class _ProductFabState extends State<ProductFab> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 55,
              width: 56,
              alignment: FractionalOffset.topCenter,
              child: FloatingActionButton(
                onPressed: () {},
                child: Icon(
                  Icons.mail,
                  color: Theme.of(context).primaryColor,
                ),
                mini: true,
                heroTag: 'contact',
                backgroundColor: Theme.of(context).cardColor,
              ),
            ),
            Container(
              height: 55,
              width: 56,
              alignment: FractionalOffset.topCenter,
              child: FloatingActionButton(
                onPressed: () {
                  model.toggleProductFavoriteStatus();
                },
                child: Icon(
                  model.selectedProduct.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                mini: true,
                heroTag: 'favorite',
                backgroundColor: Theme.of(context).cardColor,
              ),
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.more_vert),
              heroTag: 'options',
            ),
          ],
        );
      },
    );
  }
}
