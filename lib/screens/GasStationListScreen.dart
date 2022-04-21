import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../Colors.dart';
import '../Strings.dart';
import 'DetailScreen.dart';
import '../main.dart';

class GasStationListScreen extends StatefulWidget {
  const GasStationListScreen({Key? key}) : super(key: key);

  @override
  _GasStationListScreenState createState() => _GasStationListScreenState();
}

class _GasStationListScreenState extends State<GasStationListScreen> {
  final List<Map<String, dynamic>> _gasStations = [];

  bool isSearchClicked = false;
  final TextEditingController _filter = TextEditingController();
  final store = getIt<MainStore>();

  @override
  initState() {
    store.getGasStationsAtCurrentLocation();
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String,dynamic>> results = [];//List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _gasStations;
    } else  {
      results = _gasStations
          .where((gasStation) =>
          gasStation["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.list_title),

        actions: [
          PopupMenuButton<int>(icon: Icon(Icons.sort),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) =>
              [
                const PopupMenuItem<int>(
                    value: 0,
                    child: Text(Strings.list_sort_name,)),
                const PopupMenuItem<int>(
                    value: 1,
                    child: Text(Strings.list_sort_price)),
                const PopupMenuItem<int>(
                    value: 2,
                    child: Text(Strings.list_sort_distance))
              ]),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: Strings.list_search_placeholder, suffixIcon: Icon(Icons.search)),
            ),

            const SizedBox(
              height: 8,
            ),

            Expanded(
              child: Observer(builder: (_) {
                return store.gasStations.isNotEmpty ?
                ListView.builder(
                  itemCount: store.gasStations.length,
                  itemBuilder: (context, index) =>
                      Card(
                        key: ValueKey(store.gasStations[index].id),
                        color: CustomColors.primaryLight,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListTile(
                            title:  Text(
                                store.gasStations[index].name.truncate(15),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Robot',fontStyle: FontStyle.normal)
                            ),
                            subtitle: Wrap(
                              spacing: 8,
                              children: <Widget>[
                                Text('${store.gasStations[index].distance?.toStringAsFixed(2) ?? "--"} km'),
                                Text(store.gasStations[index].location.city.toString().truncate(26),
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                            trailing: Wrap(
                              spacing: 4,
                              direction: Axis.horizontal,
                              children: <Widget>[
                              Text(
                                   getPriceForStandardFuelType(index),
                                    textScaleFactor: 1,
                                    style: const TextStyle(fontSize: 38,fontWeight: FontWeight.normal,fontFamily: 'Robot',fontStyle: FontStyle.normal)
                                  ),
                              Wrap(
                                spacing: 8,
                                direction: Axis.vertical,
                                children: <Widget>[
                                  const Text(
                                    '€/l',
                                    textScaleFactor: 1,
                                  ),
                                  Text(
                                    getFuelType(store.standardFuelType),
                                    textScaleFactor: 1,
                                  ),
                                  ],
                              ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailScreen(
                                      gasStation: store.gasStations[index]
                                  );
                                })
                              );
                            },
                          ),
                        ),
                      ),
                ) : const Text(
                      Strings.list_no_result,
                      style: TextStyle(fontSize: 24),
                );
              })
            ),
          ],
        ),
      ),
    );

    }


  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        store.sortGasStationsBy(Sort.name);
        break;
      case 1:
        store.sortGasStationsBy(Sort.price);
        break;
      case 2:
        store.sortGasStationsBy(Sort.distance);
    }
  }

  String getPriceForStandardFuelType(int index) {
    if (store.gasStations[index].prices.isNotEmpty) {
      for (var price in store.gasStations[index].prices) {
        if (price.fuelType == store.standardFuelType){
          return price.amount.toString();
        }
      }
    }
    return "-";
  }

}

extension StringExtension on String {
  String truncate(maxLength) {
    if (this.length <= maxLength) { return this; }
    return replaceRange(maxLength, this.length, "...");
  }
}

