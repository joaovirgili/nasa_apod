import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'apod_details_controller.dart';

class ApodDetailsPage extends StatefulWidget {
  final String title;
  const ApodDetailsPage({Key key, this.title = "ApodDetails"})
      : super(key: key);

  @override
  _ApodDetailsPageState createState() => _ApodDetailsPageState();
}

class _ApodDetailsPageState
    extends ModularState<ApodDetailsPage, ApodDetailsController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
