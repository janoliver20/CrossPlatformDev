import 'package:Me_Fuel/models/GasStation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Strings.dart';
import '../main.dart';
import '../stores/main_store.dart';

class UserScreen extends StatefulWidget {

  const UserScreen({Key? key}) : super(key: key);
  
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  void initState() {
    super.initState();
  }

  int segmentedControlValue = 0;
  final store = getIt<MainStore>();
  final nameController = TextEditingController();
  String userName = "no Name";


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    super.dispose();
  }

  String changeName(){
    String newName = "";

    return newName;
  }

  Widget segmentedControl() {
    return Container(
      height: 40,
      width: double.infinity,
      child: CupertinoSlidingSegmentedControl(
          groupValue: getIndexFromFuelType(store.standardFuelType),
          backgroundColor: Colors.blue,
          children: const <int, Widget>{
            0: Padding(padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text(Strings.fuelType_diesel)),
            1: Padding(padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text(Strings.fuelType_super)),
            2: Padding(padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text(Strings.fuelType_gas)),
          },
          onValueChanged: (value) {
            setState(() {
              segmentedControlValue = value as int;
                store.setDefaultFuelType(getFuelTypeFromIndex(value));
            });
          }
      ),
    );
  }

  FuelType getFuelTypeFromIndex(int index){
    if ( index == 0 ) {
      return FuelType.die;
    } else if ( index == 1 ) {
      return FuelType.sup;
    } else if ( index == 2 ) {
      return FuelType.gas;
    }
    return FuelType.die;
  }

  int getIndexFromFuelType(FuelType fueltype){
    if ( fueltype ==  FuelType.die) {
      return 0;
    } else if ( fueltype == FuelType.sup ) {
      return 1;
    } else if ( fueltype == FuelType.gas ) {
      return 2;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.user_settings_title),
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                CircleAvatar(
              radius: 100,
              backgroundColor: Colors.transparent,
              child: ClipOval( child: Image.asset("assets/icons/male-user-100.png",width: 100,
                height: 100,
                fit: BoxFit.cover,),
              )
            ),
              store.username.toString().isEmpty ? TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Change username',
                )
              ) : Text(store.username.toString(),
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold, fontFamily: 'Robot',fontStyle: FontStyle.normal)),
              const SizedBox(height: 40),
              const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                Strings.intro_fuelType_question,
              ),
          ),
              const SizedBox(height: 12),
              segmentedControl(),
        ]
      )
      ),
    );

  }

}
