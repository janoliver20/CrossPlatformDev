import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          groupValue: segmentedControlValue,
          backgroundColor: Colors.blue,
          children: const <int, Widget>{
            0: Padding(padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text('Diesel')),
            1: Padding(padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text('Super')),
            2: Padding(padding: EdgeInsets.only(top: 8.0,bottom: 8.0),
                child: Text('Gas')),
          },
          onValueChanged: (value) {
            setState(() {
              segmentedControlValue = value as int;
            });
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Settings"),
      ),
      body: Container(
          margin: const EdgeInsets.all(20),
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval( child: Image.asset("assets/icons/male-user-100.png",width: 100,
                height: 100,
                fit: BoxFit.cover,),
              )
            ),
             // const SizedBox(height: 20),
            //  Text(store.username.toString().isEmpty ? nameController.text : store.username.toString(),
            //      style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Robot',fontStyle: FontStyle.normal)),
              const SizedBox(height: 20),
              store.username.toString().isEmpty ? TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Change username',
                )
              ) : Text(store.username.toString(),
                  style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,fontFamily: 'Robot',fontStyle: FontStyle.normal)),
              const SizedBox(height: 20),
              const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Fuel type:",
              ),
          ),
              const SizedBox(height: 20),
              segmentedControl(),
              const SizedBox(height: 40),
              const SizedBox( width: 200,
                      child: ElevatedButton(onPressed: null, child: Text('SAVE'))
                  ),


        ]
          )

      ),
    );

  }

}
