// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainStore on _MainStore, Store {
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
  Computed<FuelType>? _$standardFuelTypeComputed;

  @override
  FuelType get standardFuelType => (_$standardFuelTypeComputed ??=
          Computed<FuelType>(() => super.standardFuelType,
              name: '_MainStore.standardFuelType'))
      .value;
  Computed<bool>? _$hasAlreadyReadIntroComputed;

  @override
  bool get hasAlreadyReadIntro => (_$hasAlreadyReadIntroComputed ??=
          Computed<bool>(() => super.hasAlreadyReadIntro,
              name: '_MainStore.hasAlreadyReadIntro'))
      .value;

  final _$_hasAlreadyReadIntroAtom =
      Atom(name: '_MainStore._hasAlreadyReadIntro');

  @override
  bool get _hasAlreadyReadIntro {
    _$_hasAlreadyReadIntroAtom.reportRead();
    return super._hasAlreadyReadIntro;
  }

  @override
  set _hasAlreadyReadIntro(bool value) {
    _$_hasAlreadyReadIntroAtom.reportWrite(value, super._hasAlreadyReadIntro,
        () {
      super._hasAlreadyReadIntro = value;
    });
  }

  final _$_sortOptionAtom = Atom(name: '_MainStore._sortOption');

  @override
  Sort get _sortOption {
    _$_sortOptionAtom.reportRead();
    return super._sortOption;
  }

  @override
  set _sortOption(Sort value) {
    _$_sortOptionAtom.reportWrite(value, super._sortOption, () {
      super._sortOption = value;
    });
  }

  final _$_sortFuelTypeAtom = Atom(name: '_MainStore._sortFuelType');

  @override
  FuelType? get _sortFuelType {
    _$_sortFuelTypeAtom.reportRead();
    return super._sortFuelType;
  }

  @override
  set _sortFuelType(FuelType? value) {
    _$_sortFuelTypeAtom.reportWrite(value, super._sortFuelType, () {
      super._sortFuelType = value;
    });
  }

  final _$_sortAscAtom = Atom(name: '_MainStore._sortAsc');

  @override
  bool get _sortAsc {
    _$_sortAscAtom.reportRead();
    return super._sortAsc;
  }

  @override
  set _sortAsc(bool value) {
    _$_sortAscAtom.reportWrite(value, super._sortAsc, () {
      super._sortAsc = value;
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

  final _$_standardFuelTypeAtom = Atom(name: '_MainStore._standardFuelType');

  @override
  FuelType get _standardFuelType {
    _$_standardFuelTypeAtom.reportRead();
    return super._standardFuelType;
  }

  @override
  set _standardFuelType(FuelType value) {
    _$_standardFuelTypeAtom.reportWrite(value, super._standardFuelType, () {
      super._standardFuelType = value;
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
  void setDefaultFuelType(FuelType fuelType) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.setDefaultFuelType');
    try {
      return super.setDefaultFuelType(fuelType);
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
      {FuelType? fuelType,
      dynamic includeClosed = false,
      dynamic listOption = GasStationListOperationOption.replace}) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.getGasStationsInRegion');
    try {
      return super.getGasStationsInRegion(region,
          fuelType: fuelType,
          includeClosed: includeClosed,
          listOption: listOption);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getGasStationAtLocation(double latitude, double longitude,
      {FuelType? fuelType,
      dynamic includeClosed = false,
      dynamic listOption = GasStationListOperationOption.replace}) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore.getGasStationAtLocation');
    try {
      return super.getGasStationAtLocation(latitude, longitude,
          fuelType: fuelType,
          includeClosed: includeClosed,
          listOption: listOption);
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
  void _addToGasStationList(
      List<GasStation> elements, GasStationListOperationOption option) {
    final _$actionInfo = _$_MainStoreActionController.startAction(
        name: '_MainStore._addToGasStationList');
    try {
      return super._addToGasStationList(elements, option);
    } finally {
      _$_MainStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
standardFuelType: ${standardFuelType},
hasAlreadyReadIntro: ${hasAlreadyReadIntro}
    ''';
  }
}
