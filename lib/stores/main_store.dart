
import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/models/Region.dart';
import 'package:Me_Fuel/models/RegionUnit.dart';
import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:Me_Fuel/services/e-control/gasstation_fuel_merge.service.dart';
import 'package:Me_Fuel/services/location.service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

enum Sort {
  name,
  price,
  distance,
  non
}

enum GasStationListOperationOption {
  append,
  replace
}

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  final EControlAPI _eControlAPI = EControlAPI();

  MainStore() => autorun((_) {
    if (error != null) {
      print("Error: " + error.toString());
    }
  });

  Sort _sortOption = Sort.non;
  FuelType? _sortFuelType;
  bool _sortAsc = true;

  @observable
  int _value = 0;

  @observable
  dynamic _error;

  @observable
  bool _isLoading = false;

  ObservableList<Region> regions = ObservableList.of([]);

  ObservableList<RegionUnit> regionUnits = ObservableList.of([]);

  ObservableList<GasStation> gasStations = ObservableList.of([]);

  @computed
  int get value => _value;

  @computed
  bool get isLoading => _isLoading;

  @computed
  dynamic get error => _error;

  @action
  void increment() {
    _value++;
  }

  @action
  void getRegions({includeCities = true}) {
    _isLoading = true;
    _eControlAPI.queryRegions(includeCities: includeCities)
        .then((val){
          regions.clear();
          regions.addAll(val);
        })
        .catchError((err) => _error = err)
        .whenComplete(() => _isLoading = false);

  }

  @action
  void getRegionUnits() {
    _isLoading = true;
    _eControlAPI.queryRegionUnits()
        .then((value){
          regionUnits.clear();
          regionUnits.addAll(value);
        })
        .catchError((err) => _error = err)
        .whenComplete(() => _isLoading = false);
  }

  @action
  void getGasStationsAtCurrentLocation({FuelType? fuelType, includeClosed = false}) {
    _isLoading = true;
    LocationService
        .determinePosition(desiredAccuracy: LocationAccuracy.high)
        .then((position) => {
          _eControlAPI
              .queryGasStationsByAddress(latitude: position.latitude, longitude: position.longitude, includeClosed: includeClosed, fuelType: fuelType)
              .then((gasStationList){
                gasStations.clear();
                gasStations.addAll(gasStationList);
                  })
              .catchError((err) => _error = err)

    })
        .catchError((err) => _error = err)
        .whenComplete(() => _isLoading = false);
  }

  @action
  void getGasStationsInRegion(Region region, {FuelType? fuelType, includeClosed = false, listOption = GasStationListOperationOption.replace}) {
    _isLoading = true;
    _eControlAPI.queryGasStationsByRegion(code: region.code, regionType: region.regionType)
        .then((gasStationList) => _addToGasStationList(gasStationList, listOption))
        .catchError((err) => _error = err)
        .whenComplete(() => _isLoading = false);
  }

  @action
  void getGasStationAtLocation(double latitude, double longitude, {FuelType? fuelType, includeClosed = false, listOption = GasStationListOperationOption.replace}){
    _isLoading = true;
    _eControlAPI.queryGasStationsByAddress(latitude: latitude, longitude: longitude, includeClosed: includeClosed, fuelType: fuelType)
    .then((gasStationList) => _addToGasStationList(gasStationList, listOption))
    .catchError((err) => _error = err)
    .whenComplete(() => _isLoading = false);
  }

  @action
  void sortGasStationsBy(Sort sort, {FuelType? fuelType, bool asc = true}) {
    if (gasStations.isNotEmpty) {
      _sortOption = sort;
      _sortFuelType = fuelType;
      _sortAsc = asc;
      gasStations.sort((a, b) {
        switch (sort) {
          case Sort.name:
            return a.name.compareTo(b.name) * (asc ? 1 : -1);
          case Sort.price:
            if (fuelType != null) {
              return a.prices
                  .firstWhere((element) => element.fuelType == fuelType)
                  .amount
                  .compareTo(b.prices
                  .firstWhere((element) => element.fuelType == fuelType)
                  .amount) * (asc ? 1 : -1);
            }
            return (a.prices.isNotEmpty ? a.prices[0].amount : double.maxFinite)
                .compareTo(b.prices.isNotEmpty ? b.prices[0].amount : double.maxFinite) * (asc ? 1 : -1);
          case Sort.distance:
            return (a.distance ?? double.maxFinite)
                .compareTo(b.distance ?? double.maxFinite) * (asc ? 1 : -1);
          case Sort.non:
            return 0;
        }
      });
    }
  }

  @action
  void _addToGasStationList(List<GasStation> elements, GasStationListOperationOption option) {
    switch(option) {
      case GasStationListOperationOption.replace:
        gasStations.clear();
        gasStations.addAll(elements);
        break;
      case GasStationListOperationOption.append:
        gasStations = ObservableList.of(GasStationFuelMerge.mergeGasStations([gasStations, elements]));
    }
    if (_sortOption != Sort.non) {
      sortGasStationsBy(_sortOption, fuelType: _sortFuelType, asc: _sortAsc);
    }
  }
}