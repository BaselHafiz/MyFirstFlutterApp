import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File _imageFile;

  void _getImage(BuildContext context, ImageSource source) {
    ImagePicker.pickImage(source: source, maxWidth: 400).then((File image) {
      setState(() {
        _imageFile = image;
      });
      Navigator.pop(context);
    });
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150,
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Text('Pick an Image',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _getImage(context, ImageSource.camera);
                  },
                  child: Text('Use Camera'),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _getImage(context, ImageSource.gallery);
                  },
                  child: Text('Use Gallary'),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlineButton(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 2),
          onPressed: () {
            _openImagePicker(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.camera_alt, color: Theme.of(context).primaryColor),
              SizedBox(width: 5),
              Text('Add Image',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ],
          ),
        ),
        SizedBox(height: 10),
        _imageFile == null
            ? Text('Pick up an image')
            : Image.file(
                _imageFile,
                fit: BoxFit.cover,
                height: 300,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
              )
      ],
    );
  }
}
