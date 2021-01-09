import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/entities/apod_entity.dart';
import '../../shared/components/app_smart_refresher.dart';
import '../../shared/formatters/date_formatter.dart';
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

  bool _listReachedPercentage(double percent) {
    return _scrollController.offset >=
        _scrollController.position.maxScrollExtent * percent;
  }

  void _clearDate() => controller.setSelectedDate(null);

  void _openDatePicker() async {
    final date = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2002),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      controller.setSelectedDate(date);
    }
  }

  void _onApodTap(ApodEntity apod) {
    Modular.to.pushNamed(AppRoutes.apodDetails, arguments: apod);
  }

  bool filterApodByTitle(ApodEntity apod, String search) {
    if (search == null) {
      return true;
    }
    return apod.title.toUpperCase().contains(search.toUpperCase());
  }

  bool filterApodByDate(ApodEntity apod, DateTime date) {
    if (date == null) {
      return true;
    }
    return apod.date == date;
  }

  void _openErrorSnackbar() {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text("Failed to fetch data!")),
    );
  }

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
        if (hasError) _openErrorSnackbar();
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
          Padding(
            padding: const EdgeInsets.all(12),
            child: _buildTitleFilter(),
          ),
          _buildDateFilter(),
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

  TextField _buildTitleFilter() => TextField(
        onChanged: controller.setSearch,
        decoration: InputDecoration(
          hintText: "search by title",
        ),
      );

  Row _buildDateFilter() {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.calendar_today),
          onPressed: _openDatePicker,
        ),
        Observer(builder: (_) {
          return Text(controller.selectedDate == null
              ? "Select date to filter"
              : DateFormatter.format(controller.selectedDate));
        }),
        Spacer(),
        RaisedButton(child: Text("Clear date"), onPressed: _clearDate),
      ],
    );
  }

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
                  .where((apod) => filterApodByTitle(apod, controller.search))
                  .where(
                      (apod) => filterApodByDate(apod, controller.selectedDate))
                  .map((apod) => ApodCardWidget(
                        apod: apod,
                        onTap: () => _onApodTap(apod),
                      ))
                  .toList(),
        ),
      );
    });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
