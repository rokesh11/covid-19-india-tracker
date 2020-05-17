import 'package:covid19/geolocator_service.dart';
import 'package:covid19/map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class PreMap extends StatelessWidget {
  final geoService=GeoLocatorService();
  @override
  Widget build(BuildContext context) {
    return FutureProvider(
      create: (context)=> geoService.getInitialLocation(),
      child: MaterialApp(
        home: Consumer<Position>(builder: (context,position,widget){
          return (position!=null)? Map(position):Center(child: CircularProgressIndicator(),);
        },),
      ),
    );
  }

  move(context,position){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return Map(position);
    }));
  }
}
