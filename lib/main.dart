import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng carLocation = LatLng(23.1431222, 77.4127234);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = carLocation;
  LatLng startLocation = LatLng(23.1431222, 77.4127234);

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addMarkers();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }


  void _onAddMarkerButtonPressed() {
    setState(() {
    });
  }


  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maps Sample App'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: carLocation,
                zoom: 11.0,
              ),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget> [
                    FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.map, size: 36.0),
                    ),
                    SizedBox(height: 16.0),
                    FloatingActionButton(
                      onPressed: _onAddMarkerButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add_location, size: 36.0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addMarkers() async {

    // from server Image
   /* String imgurl = "https://www.fluttercampus.com/img/car.png";
    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
        .load(imgurl))
        .buffer
        .asUint8List();

    _markers.add(
    Marker( //add start location marker
    markerId: MarkerId(carLocation.toString()),
    position: carLocation, //position of marker
    infoWindow: InfoWindow( //popup info
    title: 'Car Point ',
    snippet: 'Car Marker',
    ),
    icon: BitmapDescriptor.fromBytes(bytes), //Icon for Marker
    )
    );*/


    //from assets
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/image/location128.png",
    );

    _markers.add(
        Marker( //add start location marker
          markerId: MarkerId(startLocation.toString()),
          position: startLocation, //position of marker
          infoWindow: const InfoWindow( //popup info
            title: 'Starting Point ',
            snippet: 'Start Marker',
          ),
          icon: markerbitmap, //Icon for Marker
        )
    );
    setState(() {
      //refresh UI
    });
  }
}