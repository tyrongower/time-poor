import 'package:flutter/material.dart';
import 'package:time_poor_app/TimePoorPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tys Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          accentColor: Colors.redAccent,
      ),
      checkerboardOffscreenLayers: false,
        checkerboardRasterCacheImages: false,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
      home: TimePoor(),
    );
  }
}


