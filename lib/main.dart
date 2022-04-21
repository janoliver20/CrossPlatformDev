import 'package:Me_Fuel/screens/GasStationListScreen.dart';
import 'dart:async';
import 'package:Me_Fuel/screens/IntroScreen.dart';
import 'package:Me_Fuel/screens/MapScreen.dart';
import 'package:Me_Fuel/screens/UserScreen.dart';
import 'package:Me_Fuel/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import 'Strings.dart';

final getIt = GetIt.asNewInstance();

Future<void> main() async {
  await dotenv.load();
  getIt.registerLazySingleton(() => MainStore());
  final store = getIt<MainStore>();
  await store.setup();
  store.getGasStationsAtCurrentLocation();
  runApp(MyApp(hasAlreadyReadIntro: store.hasAlreadyReadIntro));
}

class MyApp extends StatelessWidget {
  final bool hasAlreadyReadIntro;
  const MyApp({Key? key, required this.hasAlreadyReadIntro}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeFuel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: hasAlreadyReadIntro ? const MyHomePage(title: 'MeFuel Homepage') : const IntroScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final store = getIt<MainStore>();

  @override
  void initState() {
    super.initState();
    checkForLocationPermission();
    store.getRegions();
    store.getGasStationsAtCurrentLocation();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[

    const GasStationListScreen(),
    const MapScreen(),
    const UserScreen()

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.list), label: Strings.bottom_gas_station_list_screen),
          const BottomNavigationBarItem(icon: Icon(Icons.map), label: Strings.bottom_map_screen),
          BottomNavigationBarItem(icon: Image.asset("assets/icons/user24.png"), label: Strings.bottom_user_screen)
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
