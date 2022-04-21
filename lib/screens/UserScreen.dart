import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              const SizedBox(height: 40),
              CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval( child: Image.asset("assets/icons/male-user-100.png",width: 100,
                height: 100,
                fit: BoxFit.cover,),
              )
            ),
              const SizedBox(height: 40),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                )
              ),
              const SizedBox(height: 40),
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