import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _title = '';
  String _description = '';
  double _price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              _title = value;
            });
          },
        ),
        TextField(
          maxLines: 3,
          onChanged: (String value) {
            setState(() {
              _description = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              _price = double.parse(value);
            });
          },
        ),
      ],
    );
  }
}
