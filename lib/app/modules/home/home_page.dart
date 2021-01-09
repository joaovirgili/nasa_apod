import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/entities/apod_entity.dart';
import '../../shared/components/app_smart_refresher.dart';
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
  final _refreshController = RefreshController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ReactionDisposer errorReaction;
  ReactionDisposer loadingReaction;

  bool _listReachedPercentage(double percent) =>
      _scrollController.offset >=
      _scrollController.position.maxScrollExtent * percent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchApodList();
    });

    _scrollController.addListener(() {
      if (_listReachedPercentage(0.85)) {
        if (!controller.hasError && !controller.isLoadingNextPage) {
          controller.fetchApodNextPage();
        }
      }
    });

    errorReaction = reaction<bool>(
      (_) => controller.hasError,
      (hasError) {
        if (hasError)
          scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text("Failed to fetch data!")));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
    errorReaction();
    loadingReaction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Observer(
              builder: (_) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: controller.isLoading
                      ? _buildLoading()
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
    return Observer(builder: (_) {
      return AppSmartRefresher(
        controller: _refreshController,
        isLoading: controller.isLoading,
        onRefresh: controller.fetchApodList,
        hasError: controller.hasError,
        child: ListView(
          controller: _scrollController,
          children: controller.hasError
              ? <Widget>[]
              : controller.apodList
                  .map((apod) => ApodCardWidget(
                        apod: apod,
                        onTap: () => _onApodTap(apod),
                      ))
                  .toList(),
        ),
      );
    });
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
