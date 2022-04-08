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
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well
  final List<Map<String, dynamic>> _allStations = [
    /*{
      "id": 1,
      "name": "OMV",
      "price": 1.2345,
      "distance": 1.4,
      "location": "Linz"
    },
    {
      "id": 2,
      "name": "Shell",
      "price": 2.2346,
      "distance": 9.6,
      "location": "Engerwitzdorf"
    },
    {
      "id": 3,
      "name": "Lagerhaus",
      "price": 1.9875,
      "distance": 2.6,
      "location": "Pregarten"
    },
    {
      "id": 4,
      "name": "Turmöl",
      "price": 2.0034,
      "distance": 3.5,
      "location": "Hagenberg"
    },
    {
      "id": 5,
      "name": "BP",
      "price": 1.8421,
      "distance": 0.9,
      "location": "Unterweitersdorf"
    },
    {
      "id": 6,
      "name": "OMV",
      "price": 1.2345,
      "distance": 1.4,
      "location": "Liezen"
    },
    {
      "id": 7,
      "name": "Shell",
      "price": 2.2346,
      "distance": 9.6,
      "location": "Donau"
    },
    {
      "id": 8,
      "name": "Lagerhaus",
      "price": 1.9875,
      "distance": 2.6,
      "location": "Wien"
    },
    {
      "id": 9,
      "name": "Turmöl",
      "price": 2.0034,
      "distance": 3.5,
      "location": "Graz"
    },
    {
      "id": 10,
      "name": "BP",
      "price": 1.8421,
      "distance": 0.9,
      "location": "Salzburg"
    },
    {
      "id": 11,
      "name": "OMV",
      "price": 1.2345,
      "distance": 1.4,
      "location": "Urfahr"
    },
    {
      "id": 12,
      "name": "Shell",
      "price": 2.2346,
      "distance": 9.6,
      "location": "Steyr"
    },
    {
      "id": 13,
      "name": "Lagerhaus",
      "price": 1.9875,
      "distance": 2.6,
      "location": "Voest"
    },
    {
      "id": 14,
      "name": "Turmöl",
      "price": 2.0034,
      "distance": 3.5,
      "location": "Land"
    },
    {
      "id": 15,
      "name": "BP",
      "price": 1.8421,
      "distance": 0.9,
      "location": "Feld"
    },*/

  ];


  Icon _searchIcon = Icon(Icons.search);
  bool isSearchClicked = false;
  final TextEditingController _filter = new TextEditingController();
  final store = getIt<MainStore>();

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundStations = [];
  List<String> dropDown = <String>[
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
    _foundStations = _allStations;

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String,dynamic>> results = [];//List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allStations;
    } else  {
      results = _allStations
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundStations = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Tankstellen'),

        actions: [

          /*IconButton(
              onPressed: () =>
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: Icon(Icons.search)),
          */
          PopupMenuButton<int>(icon: Icon(Icons.sort),
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) =>
              [
                PopupMenuItem<int>(
                    value: 0,
                    child: Text(dropDown[0])),
                PopupMenuItem<int>(
                    value: 1,
                    child: Text(dropDown[1])),
                PopupMenuItem<int>(
                    value: 2,
                    child: Text(dropDown[2])),
                PopupMenuItem<int>(
                    value: 3,
                    child: Text(dropDown[3]))
              ]),

        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),

            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Observer(builder: (_) {
                return store.gasStations.isNotEmpty ?
                ListView.builder(
                  itemCount: store.gasStations.length,
                  itemBuilder: (context, index) =>
                      Card(
                        key: ValueKey(store.gasStations[index].id),
                        color: Colors.black12,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListTile(
                            title:  Text(
                              truncate('${store.gasStations[index].name}', length: 20),
                              textAlign: TextAlign.left,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Robot',fontStyle: FontStyle.normal)
                            ),
                            subtitle: Wrap(
                                spacing: 12,

                                children: <Widget>[
                                  Text('${store.gasStations[index].distance?.toStringAsFixed(2) ?? "--"} km'),
                                  Text('${store.gasStations[index].location.address.toString()}',
                                textScaleFactor: 1,
                            ),
                            ],
                            ),
                            /*leading: Wrap(
                              spacing: 12,
                              direction: Axis.vertical,
                              children: <Widget>[
                               Text(
                                    store.gasStations[index].prices.isNotEmpty
                                        ? '${getFuelType(index)} ${store.gasStations[index].prices[0].amount.toString()} €'
                                        : '-- €'


                                ),
                              Text(
                                    store.gasStations[index].prices.isNotEmpty
                                        ? '${getFuelType(index)}${store.gasStations[index].prices[0].amount.toString()} €'
                                        : '-- €'


                                ),
                              ],
                            ),*/
                            /*leading: Text(
                                store.gasStations[index].prices.isNotEmpty
                                    ? '${store.gasStations[index].prices[0].amount.toString()} €'
                                    : '-- €'


                            ),*/


                            trailing: Wrap(
                              spacing: 12,
                              direction: Axis.vertical,// space between two icons
                              children: <Widget>[

                                Text(
                                    store.gasStations[index].prices.isNotEmpty
                                        ? '${getFuelType(index)}'
                                        : ''
                                  ,),
                                Text(
                                  store.gasStations[index].prices.isNotEmpty
                                      ? '${store.gasStations[index].prices[0].amount.toString()} €/l'
                                      : '-- €/l'
                                  ,textScaleFactor: 1,),

                              ],
                              ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailPage(
                                    name: store.gasStations[index].name.toString(),
                                    price: store.gasStations[index].prices.isNotEmpty ? store.gasStations[index].prices[0].amount.toString() : "--",
                                    distance: store.gasStations[index].distance?.toStringAsFixed(2) ?? "--",
                                  );
                                })
                              );
                            },
                          ),
                        ),

                        // margin: const EdgeInsets.symmetric(vertical: 10),
                        // child: ListTile(
                        //   leading: Text(
                        //     store.gasStations[index].name ?? "--",
                        //     style: const TextStyle(fontSize: 24),
                        //   ),
                        //   title: Text(
                        //       store.gasStations[index].prices.isNotEmpty
                        //           ? '${store.gasStations[index].prices[0].amount.toString() ?? "--"} €'
                        //           : '--€'),
                        //   // subtitle: Text(
                        //   //     store.gasStations[index].location.address.toString() ?? "--"),
                        //   // trailing: Wrap(
                        //   //   spacing: 12, // space between two icons
                        //   //   children: <Widget>[
                        //   //     Text('${store.gasStations[index].distance?.toString() ?? '--'} km'), // Text
                        //   //     //Icon(Icons.star), // icon
                        //   //   ],
                        //   // ),
                        //   //onTap: onTapEvent(context)
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(builder: (context) {
                        //           return DetailPage(
                        //             name: store.gasStations[index].name
                        //                 .toString() ?? "--",
                        //             price: store.gasStations[index].prices.isNotEmpty ? store.gasStations[index].prices[0].amount.toString() ?? "0" : '0',
                        //             distance: store.gasStations[index].distance?.toString() ?? "0",
                        //           );
                        //         })
                        //       //MaterialPageRoute(builder: (context) => const DetailPage()),
                        //     );
                        //   },
                        // ),
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
    fuelType = store.gasStations[index].prices[0].fuelType.toString();
    if(fuelType == "FuelType.die"){
      fuelType = "Diesel: ";
    }else  if(fuelType == "FuelType.sup"){
      fuelType = "Super: ";
    }
    else  if(fuelType == "FuelType.gas"){
      fuelType = "Gas: ";
    }
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

