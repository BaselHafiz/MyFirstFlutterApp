import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/models/product.dart';
import '../helpers/ensure_visible.dart.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/static_map_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/location_data.dart';

class LocationInput extends StatefulWidget {
  final Function setLocation;
  final Product product;

  LocationInput(this.setLocation, this.product);

  @override
  State<StatefulWidget> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  final FocusNode _addressInputFocusNode = FocusNode();
  Uri _staticMapUri;
  final TextEditingController _addressInputController = TextEditingController();
  LocationData _locationData;

  @override
  void initState() {
    _addressInputFocusNode.addListener(_updateLocation);
    if (widget.product != null) {
      getStaticMap(widget.product.location.address);
    }
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
      setState(() {
        _staticMapUri = null;
      });
      widget.setLocation(null);
      return;
    }
    if (widget.product == null) {
      final Uri uri = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {'address': address, 'key': 'AIzaSyBbKsb2PPKoMLl2-BLwIM9oeoXaFJEZQUg'},
      );
      final http.Response response = await http.get(uri);
      final decodedResponse = json.decode(response.body);
      final formattedAddress = decodedResponse['results'][0]['formatted_address'];
      final coordinates = decodedResponse['results'][0]['geometry']['location'];
      _locationData = LocationData(
          latitude: coordinates['lat'],
          longitude: coordinates['lng'],
          address: formattedAddress);
    } else {
        _locationData = widget.product.location;
    }

    final StaticMapProvider staticMapProvider =
        StaticMapProvider('AIzaSyBbKsb2PPKoMLl2-BLwIM9oeoXaFJEZQUg');
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([
      Marker('position', 'position',_locationData.latitude, _locationData.longitude)
    ],
        center: Location(_locationData.latitude, _locationData.longitude),
        width: 500,
        height: 300,
        maptype: StaticMapViewType.roadmap);
    widget.setLocation(_locationData);
    setState(() {
      _addressInputController.text = _locationData.address;
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
            validator: (String value) {
              if (value.isEmpty || _locationData == null) {
                return 'No valid location found !';
              }
            },
            decoration: InputDecoration(labelText: 'Address'),
          ),
        ),
        SizedBox(height: 15),
        Image.network(_staticMapUri.toString()),
      ],
    );
  }
}
