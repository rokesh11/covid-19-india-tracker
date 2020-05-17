import 'package:flutter/material.dart';

class BoxDisplay extends StatelessWidget {
  final Color color;
  final String text;
  final String title;

  BoxDisplay({this.color,this.text,this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 5,
        semanticContainer: true,
        child: Container(
          child:Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$title',
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontFamily: 'PT Sans Narrow',
                ),
                textAlign: TextAlign.start,),
              ),
              SizedBox(height: 4,),
              Text('$text',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'PT Sans Narrow',
                ),
                textAlign: TextAlign.right,),
            ],
          ),
        ),
      ),
    );
  }
}
