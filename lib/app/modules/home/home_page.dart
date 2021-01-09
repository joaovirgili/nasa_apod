import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/apod_entity.dart';
import '../../shared/formatters/date_formatter.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Astronomy Picture of the Day"})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  void initState() {
    super.initState();
    controller.fetchApodList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: controller.isLoading
                      ? _buildLoading()
                      : controller.hasError
                          ? _buildError()
                          : _buildApodListWidget(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildApodListWidget() {
    return ListView(
      children: controller.apodList
          .map((apod) => ApodCardWidget(apod: apod))
          .toList(),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Error"),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchApodList,
          ),
        ],
      ),
    );
  }
}

class ApodCardWidget extends StatelessWidget {
  const ApodCardWidget({
    Key key,
    @required this.apod,
  }) : super(key: key);

  final ApodEntity apod;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            Image.network(
              apod.mediaType == "video" ? apod.thumbnailUrl : apod.url,
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 12,
              right: 12,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      apod.title,
                      style: const TextStyle(color: Colors.white),
                      softWrap: true,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      DateFormatter.format(apod.date),
                      style: const TextStyle(color: Colors.white),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
