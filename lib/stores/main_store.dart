
import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/models/Region.dart';
import 'package:Me_Fuel/models/RegionUnit.dart';
import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:mobx/mobx.dart';

part 'main_store.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  final EControlAPI _eControlAPI = EControlAPI();

  @observable
  int _value = 0;

  ObservableList<Region> regions = ObservableList.of([]);

  ObservableList<RegionUnit> regionUnits = ObservableList.of([]);

  ObservableList<GasStation> gasStations = ObservableList.of([]);

  @computed
  int get value => _value;

  @action
  void increment() {
    _value++;
  }

  @action
  void getRegions({includeCities = true}) {
    _eControlAPI.queryRegions(includeCities: includeCities).then((val){
      regions.clear();
      regions.addAll(val);
    });
  }

  @action
  void getRegionUnits() {
    _eControlAPI.queryRegionUnits().then((value){
      regionUnits.clear();
      regionUnits.addAll(value);
    });
  }

  @action
  void getGasStationsAtCurrentLocation() {
    print("");
  }
}