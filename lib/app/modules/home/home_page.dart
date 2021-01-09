import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/apod_entity.dart';
import '../../shared/routes.dart';
import 'components/apod_card_widget.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Astronomy Picture of the Day"})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  final _scrollController = ScrollController();

  bool _listReachedPercentage(double percent) =>
      _scrollController.offset >=
      _scrollController.position.maxScrollExtent * percent;

  @override
  void initState() {
    super.initState();
    controller.fetchApodList();

    _scrollController.addListener(() {
      if (_listReachedPercentage(0.85)) {
        if (!controller.hasError && !controller.isLoadingNextPage) {
          controller.fetchApodNextPage();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchApodList,
          ),
        ],
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

  void _onApodTap(ApodEntity apod) =>
      Modular.to.pushNamed(AppRoutes.apodDetails, arguments: apod);

  Widget _buildApodListWidget() {
    return ListView(
      controller: _scrollController,
      children: controller.apodList
          .map((apod) => ApodCardWidget(
                apod: apod,
                onTap: () => _onApodTap(apod),
              ))
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
