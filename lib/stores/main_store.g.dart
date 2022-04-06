// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStore, Store {
  Computed<int>? _$valueComputed;

  @override
  int get value => (_$valueComputed ??=
          Computed<int>(() => super.value, name: '_MainStore.value'))
      .value;

  final _$_valueAtom = Atom(name: '_MainStore._value');

  @override
  int get _value {
    _$_valueAtom.reportRead();
    return super._value;
  }

  @override
  set _value(int value) {
    _$_valueAtom.reportWrite(value, super._value, () {
      super._value = value;
    });
  }

  final _$errorAtom = Atom(name: '_MainStore.error');

  @override
  dynamic get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(dynamic value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_MainStoreActionController = ActionController(name: '_MainStore');

  @override
  void increment() {
    final _$actionInfo =
        _$_MainStoreActionController.startAction(name: '_MainStore.increment');
    try {
      return super.increment();
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getRegions({dynamic includeCities = true}) {
    final _$actionInfo =
        _$_MainStoreActionController.startAction(name: '_MainStore.getRegions');
    try {
      return super.getRegions(includeCities: includeCities);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getRegionUnits() {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.getRegionUnits');
    try {
      return super.getRegionUnits();
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getGasStationsAtCurrentLocation(
      {FuelType? fuelType, dynamic includeClosed = false}) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.getGasStationsAtCurrentLocation');
    try {
      return super.getGasStationsAtCurrentLocation(
          fuelType: fuelType, includeClosed: includeClosed);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
error: ${error},
value: ${value}
    ''';
  }
}
