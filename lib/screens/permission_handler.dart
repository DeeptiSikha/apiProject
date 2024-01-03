import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';


class PermissionPage extends StatelessWidget {
  final permissionCamera = Permission.camera;
  final permissionLocation = Permission.location;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera and Location Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                // Request camera permission
                final status = await permissionCamera.request();
                if (status.isGranted) {
                  // Open the camera
                  print('Opening camera...');
                } else {
                  // Permission denied
                  await permissionCamera.request();
                  print('Camera permission denied.');
                }
              },
              child: Text('Open Camera'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Request location permission
                final status = await permissionLocation.request();
                if (status == PermissionStatus.granted) {
                  // Get the current location
                  final position = await Geolocator.getCurrentPosition();
                  print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                } else {
                  // Permission denied
                  print('Location permission denied.');
                }
              },
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }
}
