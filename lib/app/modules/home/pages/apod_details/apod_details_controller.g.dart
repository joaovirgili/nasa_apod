// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod_details_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ApodDetailsController = BindInject(
  (i) => ApodDetailsController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ApodDetailsController on _ApodDetailsControllerBase, Store {
  final _$valueAtom = Atom(name: '_ApodDetailsControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_ApodDetailsControllerBaseActionController =
      ActionController(name: '_ApodDetailsControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_ApodDetailsControllerBaseActionController
        .startAction(name: '_ApodDetailsControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_ApodDetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
