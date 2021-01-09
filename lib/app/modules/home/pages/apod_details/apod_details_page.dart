import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../domain/entities/apod_entity.dart';
import '../../../../shared/formatters/date_formatter.dart';
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
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: <Widget>[
          const SizedBox(height: 10),
          CachedNetworkImage(
            imageUrl: widget.apodEntity.validUrl,
            imageBuilder: (context, provider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image(image: provider),
              );
            },
          ),
          const SizedBox(height: 10),
          Text(widget.apodEntity.title, textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text(
            DateFormatter.format(widget.apodEntity.date),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(widget.apodEntity.explanation),
        ],
      ),
    );
  }
}
