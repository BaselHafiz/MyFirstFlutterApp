import 'package:flutter/material.dart';
import '../helpers/ensure_visible.dart.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/static_map_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  final FocusNode _addressInputFocusNode = FocusNode();
  Uri _staticMapUri;
  final TextEditingController _addressInputController = TextEditingController();

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);
    super.initState();
  }

  @override
  void dispose() {
    _addressInputFocusNode.removeListener(_updateLocation);
    super.dispose();
  }

  void _updateLocation() {
    if (!_addressInputFocusNode.hasFocus) {
      getStaticMap(_addressInputController.text);
    }
  }

  void getStaticMap(String address) async {
    if (address.isEmpty) {
      return;
    }
    final Uri uri = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      {'address': address, 'key': 'AIzaSyBbKsb2PPKoMLl2-BLwIM9oeoXaFJEZQUg'},
    );
    final http.Response response = await http.get(uri);
    final decodedResponse = json.decode(response.body);
    final formattedAddress = decodedResponse['results'][0]['formatted_address'];
    final coordinates = decodedResponse['results'][0]['geometry']['location'];

    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyBbKsb2PPKoMLl2-BLwIM9oeoXaFJEZQUg');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers(
        [Marker('position', 'position', coordinates['lat'], coordinates['lng'])],
        center: Location(coordinates['lat'], coordinates['lng']),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    setState(() {
      _addressInputController.text = formattedAddress;
      _staticMapUri = staticMapUri;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnsureVisibleWhenFocused(
          focusNode: _addressInputFocusNode,
          child: TextFormField(
            focusNode: _addressInputFocusNode,
            controller: _addressInputController,
            decoration: InputDecoration(labelText: 'Address'),
          ),
        ),
        SizedBox(height: 15),
        Image.network(_staticMapUri.toString()),
      ],
    );
  }
}
