import 'package:flutter/material.dart';

class GestureBox extends StatelessWidget {
  final Function callBack;
  final title,text;
  final bgColor,color;

  GestureBox({this.callBack,this.text,this.title,this.bgColor,this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: Card(
        elevation: 5,
        color: bgColor,
        //semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        //margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 20,
                    fontFamily: 'PT Sans Narrow',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                text,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'PT Sans Narrow',
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
