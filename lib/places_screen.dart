import 'package:covid19/geolocator_service.dart';
import 'package:covid19/place_model.dart';
import 'package:covid19/place_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class PlacesScreen extends StatefulWidget {
  final Position position;

  PlacesScreen({this.position});
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  List<Place> places;
  //Position position;
  final geoService=GeoLocatorService();

  @override
  void initState() {
    super.initState();
    //position=widget.position;
    getNearbyPlaces(widget.position);
  }

  //getLocation(){}

  getNearbyPlaces(Position position){

    String searchUrl="https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${position.latitude.toString()},${position.longitude.toString()}&radius=1000&type=hospital&key=AIzaSyAXHYdxxqFpMreoWU-hpZh-p8zzeNyhAoI";

    PlaceService.get().getNearbyPlaces(searchUrl).then((data){
      setState(() {
        places=data;
      });

    });
  }

  Widget createBody(){
    //getNearbyPlaces(position);
    if(places==null){
      return Center(child: CircularProgressIndicator(),);
    }else{
      return ListView(
        children: places.map((f){
          return Card(
            elevation: 5,
            child: ListTile(
              title: Text(f.name),
              leading: Image.network(f.icon),
              subtitle: Text(f.vicinity),
              trailing: Column(
                children: <Widget>[
                  Icon(Icons.star, color:Colors.yellow,),
                  Text(f.rating),
                ],
              ),
            ),
          );
        }).toList(),
      );
    }
  }
/*
  getPlaces(){
    return FutureBuilder(
      future: geoService.getInitialLocation(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return createBody();
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Hospitals'),
      ),
      body: widget.position!=null? createBody():Center(child: Text('No data found'),),
    );
  }
}
