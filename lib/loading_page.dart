import 'package:flutter/material.dart';
import 'home_page.dart';
import 'network_helper.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool test = true;

  @override
  void initState() {
    super.initState();
    check();
  }

  void check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        test=true;
        getStatesData();
      }
    } on SocketException catch (_) {
      setState(() {
        test = false;
      });
    }
  }

  void getStatesData() async {
    NetworkHelper networkHelper =
        NetworkHelper(url: 'https://api.covid19india.org/data.json');
    var stateWise = await networkHelper.getData();

    NetworkHelper networkHelper1 =
        NetworkHelper(url: 'https://api.covid19india.org/states_daily.json');
    var temp = await networkHelper1.getData();
    int len = temp['states_daily'].length;
    var dailyStateWise = [
      temp['states_daily'][len - 1],
      temp['states_daily'][len - 2],
      temp['states_daily'][len - 3]
    ];

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return MyHomePage(
          statesData: stateWise['statewise'], dailyStateData: dailyStateWise);
    }));
  }

  bodyWidget() {
    if (test) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitDoubleBounce(
              color: Colors.blue,
              size: 100.0,
            ),
            Text(
              'Loading..',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 10,
              ),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No Internet Connection!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
              color:Colors.blue,
              child: Text(
                'Retry',
                style: TextStyle(color: Colors.white,fontSize: 15,),
              ),
              onPressed: () {
                setState(() {
                  test = false;
                  check();
                });
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: bodyWidget(),
      ),
    );
  }
}
