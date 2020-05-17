import 'package:flutter/material.dart';
import 'loading_page.dart';
import 'set_portrait.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with PortraitModeMixin{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MaterialApp(
      title: 'Covid19 India',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
    );
  }
}

