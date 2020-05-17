import 'package:covid19/place_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceService{
  static final _service=new PlaceService();

  static PlaceService get(){
    return _service;
  }

  //final String searchUrl="https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=,&radius=1000&type=hospital&key=AIzaSyAXHYdxxqFpMreoWU-hpZh-p8zzeNyhAoI";

  Future<List<Place>> getNearbyPlaces(searchUrl) async{

    var response=await http.get(searchUrl,headers: {"Accept":"application/json"});
    var places=<Place>[];

    List data=json.decode(response.body)['results'];

    data.forEach((f) => places.add(Place(icon:f['icon'],name: f['name'],rating: f['rating'].toString(),vicinity: f['vicinity'],id: f['place_id'])));
    return places;
  }
}