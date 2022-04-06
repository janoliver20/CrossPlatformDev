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
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_MainStore.isLoading'))
      .value;
  Computed<dynamic>? _$errorComputed;

  @override
  dynamic get error => (_$errorComputed ??=
          Computed<dynamic>(() => super.error, name: '_MainStore.error'))
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

  final _$_errorAtom = Atom(name: '_MainStore._error');

  @override
  dynamic get _error {
    _$_errorAtom.reportRead();
    return super._error;
  }

  @override
  set _error(dynamic value) {
    _$_errorAtom.reportWrite(value, super._error, () {
      super._error = value;
    });
  }

  final _$_isLoadingAtom = Atom(name: '_MainStore._isLoading');

  @override
  bool get _isLoading {
    _$_isLoadingAtom.reportRead();
    return super._isLoading;
  }

  @override
  set _isLoading(bool value) {
    _$_isLoadingAtom.reportWrite(value, super._isLoading, () {
      super._isLoading = value;
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
  void getGasStationsInRegion(Region region,
      {FuelType? fuelType, dynamic includeClosed = false}) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.getGasStationsInRegion');
    try {
      return super.getGasStationsInRegion(region,
          fuelType: fuelType, includeClosed: includeClosed);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void sortGasStationsBy(Sort sort, {FuelType? fuelType, bool asc = true}) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.sortGasStationsBy');
    try {
      return super.sortGasStationsBy(sort, fuelType: fuelType, asc: asc);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
isLoading: ${isLoading},
error: ${error}
    ''';
  }
}
