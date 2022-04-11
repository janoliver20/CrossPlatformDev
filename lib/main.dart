import 'dart:math';

import 'package:Me_Fuel/HomePage.dart';
import 'dart:async';

import 'package:Me_Fuel/Screens/DemoScreen.dart';
import 'package:Me_Fuel/services/e-control/e-control_api.dart';
import 'package:Me_Fuel/screens/MapScreen.dart';
import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

final getIt = GetIt.asNewInstance();
final store = getIt<MainStore>();

Future<void> main() async {
  await dotenv.load();
  getIt.registerLazySingleton(() => MainStore());

  var econtrol = EControlAPI();
  // econtrol.queryRegionUnits().then((value) {
  //   inspect(value);
  // });
  // econtrol.queryRegions().then((value) {
  //   inspect(value);
  // });
  // econtrol.queryGasStationsByRegion(code: 1, regionType: RegionType.bl, includeClosed: false).then((value) {
  //   inspect(value);
  // });

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeFuel',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MeFuel Homepage'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    checkForLocationPermission();
    store.getRegions();
    store.getGasStationsAtCurrentLocation();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      store.increment();
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[

    new HomePage(),
    new MapScreen()

  ];

  static const List<String> _pageTitles = <String>[
    "Tankstellen", "Map"
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tankstellen"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }



  Future<void> checkForLocationPermission() async {


    //TODO Show dialog for asking for permission
    final status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print('Permission denied! Ask again for Permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }

  }
}
