import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'detailPage.dart';
import 'package:flutter/foundation.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _gasStations = [];

  Icon _searchIcon = Icon(Icons.search);
  bool isSearchClicked = false;
  final TextEditingController _filter = new TextEditingController();
  final store = getIt<MainStore>();

  // This list holds the data for the list view
  List<Map<String, dynamic>> _filteredGasStations = [];
  List<String> dropDownOptions = <String>[
    "Default",
    "Name",
    "Price",
    "Distance",
    "Location"
  ];

  @override
  initState() {
    // at the beginning, all users are shown
    store.getGasStationsAtCurrentLocation();
    _filteredGasStations = _gasStations;

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

    setState(() { // Refresh the list
      _filteredGasStations = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tankstellen'),

        actions: [
          PopupMenuButton<int>(icon: Icon(Icons.sort),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) =>
              [
                PopupMenuItem<int>(
                    value: 0,
                    child: Text(dropDownOptions[0])),
                PopupMenuItem<int>(
                    value: 1,
                    child: Text(dropDownOptions[1])),
                PopupMenuItem<int>(
                    value: 2,
                    child: Text(dropDownOptions[2])),
                PopupMenuItem<int>(
                    value: 3,
                    child: Text(dropDownOptions[3]))
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
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
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
                        color: const Color.fromRGBO(181, 223, 253, 1.0),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListTile(
                            title:  Text(
                                truncate('${store.gasStations[index].name}', length: 16),
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Robot',fontStyle: FontStyle.normal)
                            ),
                            subtitle: Wrap(
                              spacing: 8,
                              children: <Widget>[
                                Text('${store.gasStations[index].distance?.toStringAsFixed(2) ?? "--"} km'),
                                Text(
                                  truncate('${store.gasStations[index].location.city.toString()}', length: 26),
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                            trailing: Wrap(
                              spacing: 0,
                              direction: Axis.horizontal,
                              children: <Widget>[
                              //Text(store.gasStations[index].prices.isNotEmpty ? '${getFuelType(index)}' : "--"),
                              Text(
                                    store.gasStations[index].prices.isNotEmpty
                                      ? '${store.gasStations[index].prices[0].amount.toString()}'
                                      : '--',
                                    textScaleFactor: 1,
                                    style: const TextStyle(fontSize: 42,fontWeight: FontWeight.normal,fontFamily: 'Robot',fontStyle: FontStyle.normal)
                                  ),
                                const Text(
                                  '€/l',
                                  textScaleFactor: 1,
                                ),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return store.gasStations[index].prices.isNotEmpty
                                      ? DetailPage(
                                    name: store.gasStations[index].name.toString(),
                                    price: store.gasStations[index].prices.isNotEmpty ? store.gasStations[index].prices[0].amount.toString() : '',
                                    distance: store.gasStations[index].distance?.toStringAsFixed(2) ?? "--",
                                    address: store.gasStations[index].location.address.toString(),
                                    fuelName: getFuelType(index).isNotEmpty ? getFuelType(index) : "Keine Angaben",
                                    long: store.gasStations[index].location.longitude,
                                    lat: store.gasStations[index].location.latitude,
                                    dayOpen: store.gasStations[index].openingHours,
                                    payment: store.gasStations[index].paymentMethods,
                                    contact: store.gasStations[index].contact,
                                    postalcode: store.gasStations[index].location.postalCode.toString(),
                                    city: store.gasStations[index].location.city.toString(),
                                    ):
                                  DetailPage(
                                    name: store.gasStations[index].name.toString(),
                                  price: store.gasStations[index].prices.isNotEmpty ? store.gasStations[index].prices[0].amount.toString() : '',
                                  distance: store.gasStations[index].distance?.toStringAsFixed(2) ?? "--",
                                  address: store.gasStations[index].location.address.toString(),
                                  //fuelName: getFuelType(index).isNotEmpty ? getFuelType(index) : "Keine Angaben",
                                  long: store.gasStations[index].location.longitude,
                                  lat: store.gasStations[index].location.latitude,
                                  dayOpen: store.gasStations[index].openingHours,
                                  payment: store.gasStations[index].paymentMethods,
                                  contact: store.gasStations[index].contact,
                                  postalcode: store.gasStations[index].location.postalCode.toString(),
                                  city: store.gasStations[index].location.city.toString(),
                                  );
                                })
                              );

                            },
                          ),
                        ),
                      ),
                )  : const Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                );
              })
            ),
          ],
        ),
      ),
    );

    }

  String truncate(String text, { length: 7, omission: '...' }) {
    if (length >= text.length) {
      return text;
    }
    return text.replaceRange(length, text.length, omission);
  }

    String getFuelType(int index){
    String fuelType ="";
    if( store.gasStations[index].prices[0].fuelType.toString().isNotEmpty){
      fuelType = store.gasStations[index].prices[0].fuelType.toString();
    }else{
      
      fuelType = "--";
    }

    if(fuelType == "FuelType.die"){
      fuelType = "Diesel: ";

    }else  if(fuelType == "FuelType.sup"){
      fuelType = "Super: ";
    }
    else  if(fuelType == "FuelType.gas"){
      fuelType = "Gas: ";
    }else {

      fuelType = "NO";

    }
    print(fuelType);
    return fuelType;
    }




void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      print('Click default');

      break;
    case 1:
      print('Click name');
      // _foundStations.sort((a, b) => a["name"].compareTo(b["name"]));
      // setState(() {});
      store.sortGasStationsBy(Sort.name);
      break;
    case 2:
      print('Click price');
      store.sortGasStationsBy(Sort.price);
      break;
    case 3:
      print('Click distance');
      store.sortGasStationsBy(Sort.distance);


  }
}}

// Search Page
class SearchPage extends StatelessWidget {
   _HomePageState _valueHome = new _HomePageState();
   SearchPage({Key? key}) : super(key: key); //const remove

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (value) => _valueHome._runFilter(value),
                controller: _controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                        _controller.clear();
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }

}

