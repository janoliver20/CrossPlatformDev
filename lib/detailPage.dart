import 'package:flutter/cupertino.dart';
import 'package:Me_Fuel/scrollView.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {

  var name, price, distance;


  DetailPage({this.name, this.price, this.distance});



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
            /*CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval( child: Image.asset("assets/images/"+name+".png",width: 100,
                height: 100,
                fit: BoxFit.cover,),
              )
            ),*/
            Image.asset("assets/images/"+name+".png",width: 600,
              height: 240,
              fit: BoxFit.cover,),
          //Text(name.toString(),textAlign: TextAlign.center,style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,letterSpacing: 5,shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]),),
            SizedBox(height: 40),
            Text("Preis",textAlign: TextAlign.center,style: const TextStyle(fontSize: 30,letterSpacing: 1,shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]),),
            SizedBox(height: 10),
            Text(price.toString() + " €",textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]),),
            SizedBox(height: 40),
            Text("Entfernung",textAlign: TextAlign.center,style: const TextStyle(fontSize: 30,letterSpacing: 1,shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]),),
            SizedBox(height: 10),
            Text(distance.toString() + " km",textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]),),

          ],
        )



      ),
    );
  }
}

