import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {

  String? currentAddress;
  Position? currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Location',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Latitude :${currentPosition?.latitude ?? ""} '),
              Text('Longitude : ${currentPosition?.longitude ?? ""}'),
              Text('Address :${currentAddress ?? ""} '),
              SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: getCurrentPosition,
                  child: Text('Get Current Location')
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission()async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
      if(permission==LocationPermission.denied){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Location permission are denied')));
        return false;
      }
    }
    if(permission==LocationPermission.deniedForever){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are denied forever')));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition()async{
    final hasPermission=await _handleLocationPermission();
    if(!hasPermission) return;
    await  Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
       currentPosition=position;
      });
      getAddressFormateLatLng(currentPosition!);
    }).catchError((e){
      debugPrint(e);
    });
  }

  Future<void> getAddressFormateLatLng(Position position)async{
    await placemarkFromCoordinates(
        currentPosition!.latitude,
        currentPosition!.longitude
    ).then((List<Placemark> placemark){
      Placemark place=placemark[0];
      setState(() {
        currentAddress='${place.street},${place.subLocality},${place.subAdministrativeArea},${place.postalCode}';
        print(place.street);
      });
    }).catchError((e){
      debugPrint(e);
    });
  }
}
