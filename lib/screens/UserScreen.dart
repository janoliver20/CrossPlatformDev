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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Container(
        //height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(alignment: Alignment.topRight,),
              CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval( child: Image.asset("assets/icons/user24.png",width: 100,
                height: 100,
                fit: BoxFit.cover,),
              )
            ),
            ],
          )

      ),
    );
  }
}