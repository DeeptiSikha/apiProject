import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapExample extends StatefulWidget {
  const GoogleMapExample({super.key});

  @override
  State<GoogleMapExample> createState() => _GoogleMapExampleState();
}

class _GoogleMapExampleState extends State<GoogleMapExample> {

  Completer<GoogleMapController> mapController = Completer();

  static final CameraPosition _kGoogle=const CameraPosition(target: LatLng(19.0759837, 72.8776559),zoom: 5);

  static const LatLng LatLang_center = const LatLng(21.2305298, 72.86389);

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline={};

  List<LatLng> listLatLng=[
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(24.879999, 74.629997),
    LatLng(16.166700, 74.833298),
    LatLng(12.971599, 77.594563),
  ];

  LatLng _lastMapPosition = LatLang_center;

  MapType currentMapType = MapType.normal;

  void initState(){
    super.initState();
    for(int i=0; i<listLatLng.length; i++){
      _marker.add(
        // added markers
          Marker(
            markerId: MarkerId(i.toString()),
            position: listLatLng[i],
            infoWindow: InfoWindow(
              title: 'HOTEL',
              snippet: '5 Star Hotel',
            ),
            icon: BitmapDescriptor.defaultMarker,
          )
      );
      setState(() {

      });
      _polyline.add(
          Polyline(
            polylineId: PolylineId('1'),
            points: listLatLng,
            color: Colors.lightGreen,
          )
      );
    }
  }

  void MapMarkerButton() {
    setState(() {
      currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void onAddMarkerButton() {
    setState(() {
      _marker.add(Marker(markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          infoWindow: InfoWindow(
              title: 'The Title',
              snippet: '5 star Rating'
          ),
          icon: BitmapDescriptor.defaultMarker
      ));
    });
  }

  void onCameraMove(CameraPosition cameraPosition) {
    _lastMapPosition = cameraPosition.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Map', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightGreen.shade300,
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _kGoogle,
            // initialCameraPosition: CameraPosition(
            //   target: LatLang_center,
            //   zoom: 10.0,
            // ),
            mapType: currentMapType,
            markers: _marker,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            polylines: _polyline,
            onCameraMove: onCameraMove,
          ),
          Padding(padding: const EdgeInsets.all(14.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed:
                      MapMarkerButton,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.lightGreen.shade300,
                    child: const Icon(Icons.map, size: 30.0, color: Colors.white,),
                  ),
                  SizedBox(height: 20,),
                  FloatingActionButton(
                    onPressed:
                    onAddMarkerButton,
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.lightGreen.shade300,
                    child: const Icon(Icons.add_location, size: 30.0, color: Colors.white,),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
