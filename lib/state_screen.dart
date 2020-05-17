import 'package:flutter/material.dart';
import 'constants.dart';
import 'box_display.dart';

class StateScreen extends StatefulWidget {
  final districtData;
  final stateName;
  final active,death,confirm,recover;

  StateScreen({this.districtData, this.stateName,this.active,this.death,this.confirm,this.recover});

  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  var districtWise;

  @override
  void initState() {
    super.initState();
    districtWise = widget.districtData;
  }

  list() {
    List<DataRow> rows = [];
    for (var i = 1; i < districtWise.length; i++) {
      DataRow r = DataRow(cells: [
        DataCell(Text(
          '${districtWise[i]['district']}',
          style: rFont,
        )),
        DataCell(Text(
          '${districtWise[i]['confirmed']}',
          style: rFont,
        )),
        DataCell(Text(
          '${districtWise[i]['active']}',
          style: rFont,
        )),
        DataCell(Text(
          '${districtWise[i]['deceased']}',
          style: rFont,
        )),
        DataCell(Text(
          '${districtWise[i]['recovered']}',
          style: rFont,
        )),
      ]);
      rows.add(r);
    }
    return rows;
  }

  districtList() {
    if(districtWise==null){
      return SizedBox.shrink();
    }
    if(districtWise.length==0){
      return SizedBox.shrink();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
              label: Text(
            'District',
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
        ],
        rows: list(),
        columnSpacing: 3,
      ),
    );
  }

  topCard() {
    return Card(
      elevation: 0,
      color: Colors.blueAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              ' ${widget.stateName}',
              style: TextStyle(
                color: Colors.white,
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
                   BoxDisplay(color: Colors.red,title:'Active',text: widget.active),
                   BoxDisplay(color: Colors.orange,title:'Confirmed',text: widget.confirm),
                 ],
               ),
                SizedBox(height:5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    BoxDisplay(color: Colors.blue,title:'Deaths',text: widget.death),
                    BoxDisplay(color: Colors.green,title:'Recovered',text: widget.recover),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid19 Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            topCard(),
            SizedBox(
              height: 5.0,
            ),
            heading(),
            SizedBox(
              height: 5.0,
            ),
            districtList(),
          ],
        ),
      ),
    );
  }

  heading(){
    if(districtWise==null){
      return Text('No data found!', style:rFont, textAlign: TextAlign.center,);
    }
    if(districtWise.length==0){
      return Text('No data found!', style:rFont, textAlign: TextAlign.center,);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'District wise Statistics',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontFamily: 'Balsamiq Sans',
          color: Colors.black,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
