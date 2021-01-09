import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../domain/entities/apod_entity.dart';
import 'apod_details_controller.dart';

class ApodDetailsPage extends StatefulWidget {
  final ApodEntity apodEntity;
  const ApodDetailsPage({Key key, @required this.apodEntity}) : super(key: key);

  @override
  _ApodDetailsPageState createState() => _ApodDetailsPageState();
}

class _ApodDetailsPageState
    extends ModularState<ApodDetailsPage, ApodDetailsController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
