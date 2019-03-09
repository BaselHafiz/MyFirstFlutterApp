import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage>{

  String _titleValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              _titleValue = value;
            });
          },
        ),
        Text(_titleValue),
      ],
    );
  }
}
