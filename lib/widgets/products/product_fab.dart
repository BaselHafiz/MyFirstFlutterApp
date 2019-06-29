import 'package:flutter/material.dart';

class ProductFab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductFabState();
  }
}

class _ProductFabState extends State<ProductFab> {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
            child: Icon(
              Icons.favorite,
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
  }
}
