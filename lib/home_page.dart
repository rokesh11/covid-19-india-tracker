import 'package:covid19/places_screen.dart';
import 'package:covid19/pre_map.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:geolocator/geolocator.dart';
import 'indicator.dart';
import 'constants.dart';
import 'state_screen.dart';
import 'network_helper.dart';
import 'box_display.dart';
import 'video_screen.dart';
import 'gesture_box.dart';
import 'symptoms_page.dart';
import 'helpline_page.dart';
import 'geolocator_service.dart';

class MyHomePage extends StatefulWidget {
  final statesData;
  final dailyStateData;
  final geoService=GeoLocatorService();

  MyHomePage({this.statesData, this.dailyStateData});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int current = 0,
      touchedIndex;
  int tActive, tDeaths, tConfirmed, tRecovered;
  var stateWise, dailyStateWise;
  var districtWise;
  Position position;

  @override
  void initState() {
    super.initState();
    stateWise = widget.statesData;
    dailyStateWise = widget.dailyStateData;
    tActive = int.parse(widget.statesData[0]['active']);
    tDeaths = int.parse(widget.statesData[0]['deaths']);
    tConfirmed = int.parse(widget.statesData[0]['confirmed']);
    tRecovered = int.parse(widget.statesData[0]['recovered']);
    getDistrictData();
    getLocation();
  }

  void getLocation() async{
    position=await widget.geoService.getInitialLocation();
  }

  void cardsCallBack(int index) {
    setState(() {
      current = index;
    });
  }

  void getDistrictData() async {
    NetworkHelper networkHelper = NetworkHelper(
        url: 'https://api.covid19india.org/v2/state_district_wise.json');
    districtWise = await networkHelper.getData();
  }

  findState(sState) {
    var temp;
    if (districtWise != null) {
      for (var i = 0; i < districtWise.length; i++) {
        if (sState == districtWise[i]['statecode']) {
          temp = districtWise[i]['districtData'];
        }
      }
    }
    return temp;
  }

  rowWidget(changes, data, color) {
    if (changes == '0') {
      return Text(
        '$data',
        style: rFont,
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.arrow_upward, size: 10, color: color,),
        Text(
          ' ($changes)',
          style: rFontColor(color),
        ),
        SizedBox(width: 4,),
        Text(
          '$data',
          style: rFont,
        ),
      ],
    );
  }

  list() {
    List<DataRow> rows = [];
    var sCode;
    for (var i = 1; i < stateWise.length; i++) {
      sCode = stateWise[i]['statecode'].toLowerCase();
      DataRow r = DataRow(cells: [
        DataCell(
          Text(
            '${stateWise[i]['state']}',
            style: rFont,
          ),
          onTap: () {
            //var confirm=int.parse(widget.statesData[i]['confirmed']);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StateScreen(
                districtData: findState(stateWise[i]['statecode']),
                stateName: stateWise[i]['state'],
                active: stateWise[i]['active'],
                confirm: stateWise[i]['confirmed'],
                death: stateWise[i]['deaths'],
                recover: stateWise[i]['recovered'],
              );
            }));
          },
        ),
        DataCell(rowWidget(dailyStateWise[2][sCode], stateWise[i]['confirmed'],
            Colors.orange),),
        DataCell(Text(
          '${stateWise[i]['active']}',
          style: rFont,
        )),
        DataCell(rowWidget(
            dailyStateWise[0][sCode], stateWise[i]['deaths'], Colors.blue),),
        DataCell(rowWidget(dailyStateWise[1][sCode], stateWise[i]['recovered'],
            Colors.green),),
        DataCell(Text(
          '${stateWise[i]['lastupdatedtime']}',
          style: rFont,
        )),
      ]);
      rows.add(r);
    }
    return rows;
  }

  statesList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(
                'State',
                style: cTitle(Colors.black),
              )),
          DataColumn(
            label: Text(
              'Confirmed',
              style: cTitle(Colors.orange),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Active',
              style: cTitle(Colors.red),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Deaths',
              style: cTitle(Colors.blue),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Recovered',
              style: cTitle(Colors.green),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Last update time',
              style: cTitle(Colors.black),
            ),
            numeric: true,
          ),
        ],
        rows: list(),
        columnSpacing: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19 India Tracker'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureBox(
                  callBack: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return VideoBox(videoId: "OZcRD9fV7jo",);
                    }));
                  },
                  title: 'Coronavirus',
                  color: Colors.white,
                  text: 'Q & A',
                  bgColor: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureBox(
                    callBack: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return Symptoms();
                      }));
                    },
                    title: 'Coronavirus',
                    color: Colors.white,
                    text: 'Symptoms',
                    bgColor: Colors.purple,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureBox(
                    callBack: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return VideoBox(videoId: "8c_UJwLq8PI",);
                      }));
                    },
                    title: 'Coronavirus',
                    color: Colors.white,
                    text: 'Prevention',
                    bgColor: Colors.blueAccent,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureBox(
                    callBack: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return HelpLine();
                      }));
                    },
                    title: 'Helpline',
                    color: Colors.white,
                    text: 'Numbers',
                    bgColor: Colors.orange,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureBox(
                    callBack: () {
                      if(position!=null){
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return PlacesScreen(position: position);
                        }));
                      }
                    },
                    title: 'Nearby',
                    color: Colors.white,
                    text: 'Hospitals',
                    bgColor: Colors.redAccent,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Safety Measures',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Balsamiq Sans',
                ),
                textAlign: TextAlign.start,
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: Duration(seconds: 6),
                autoPlayAnimationDuration: Duration(milliseconds: 1500),
                pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) {
                  cardsCallBack(index);
                },
              ),
              items: imgList
                  .map(
                    (item) =>
                    Card(
                      elevation: 5,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Image.asset(
                        item,
                        fit: BoxFit.fill,
                      ),
                    ),
              )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 6,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      ' India Covid19 Pie Representation',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Balsamiq Sans',
                      ),
                      maxLines:2,
                      textAlign: TextAlign.start,
                    ),
                    Center(
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback: (pieTouchResponse) {
                              /*setState(() {
                                if (pieTouchResponse.touchInput
                                is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });*/
                            },
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          startDegreeOffset: 180,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.0,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Indicator(
                              color: Colors.red,
                              text: 'Active ',
                              isSquare: false,
                              size: touchedIndex == 1 ? 15 : 12,
                            ),
                            Indicator(
                              color: Colors.blue,
                              text: 'Deaths ',
                              isSquare: false,
                              size: touchedIndex == 1 ? 15 : 12,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Indicator(
                              color: Colors.green,
                              text: 'Recovered',
                              isSquare: false,
                              size: touchedIndex == 1 ? 15 : 12,
                            ),
                            Indicator(
                              color: Colors.orange,
                              text: 'Confirmed',
                              isSquare: false,
                              size: touchedIndex == 1 ? 15 : 12,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            topCard(),
            SizedBox(
              height: 5.0,
            ),
            Text(
              'State wise Statistics',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Balsamiq Sans',
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 3.0,
            ),
            statesList(),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 12;
      final double radius = isTouched ? 80 : 70;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: tActive.toDouble(),
            title: '$tActive',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: tConfirmed.toDouble(),
            title: '$tConfirmed',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.blue,
            value: tDeaths.toDouble(),
            title: '$tDeaths',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: tRecovered.toDouble(),
            title: '$tRecovered',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        default:
          return null;
      }
    });
  }

  topCard() {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              ' Total Count',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Balsamiq Sans',
              ),
              textAlign: TextAlign.start,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    BoxDisplay(
                        color: Colors.red,
                        title: 'Active',
                        text: widget.statesData[0]['active']),
                    BoxDisplay(
                        color: Colors.orange,
                        title: 'Confirmed',
                        text: widget.statesData[0]['confirmed']),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    BoxDisplay(
                        color: Colors.blue,
                        title: 'Deaths',
                        text: widget.statesData[0]['deaths']),
                    BoxDisplay(
                        color: Colors.green,
                        title: 'Recovered',
                        text: widget.statesData[0]['recovered']),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
