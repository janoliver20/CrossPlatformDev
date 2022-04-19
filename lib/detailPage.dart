import 'package:flutter/cupertino.dart';
import 'package:Me_Fuel/scrollView.dart';
import 'package:flutter/material.dart';


class DetailPage extends StatelessWidget {

  var name, price, distance, address,fuelName;


  DetailPage({this.name, this.price, this.distance, this.address, this.fuelName});



  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(height: 95.0),
        Text(
          address.toString(),
          style: TextStyle(color: Colors.white, fontSize: 30.0),
        ),
        SizedBox(height: 15.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.directions_car,
              color: Colors.white,
              size: 20.0,
            ),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      distance.toString() + " km",
                      style: TextStyle(color: Colors.white),
                    ))),

          ],
        ),
      ],
    );
    final addressContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/map_test_detail.JPG"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          right: 30.0,
          bottom: 30.0,
          child: InkWell(
            onTap: () {
              print("To Map Screen");
            },
            child: Icon(Icons.map, color: Colors.green,size: 45),
          ),
        ),

      ],
    );

    final priceHeader =  Text("Preise", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,));



    final priceContentText = Text(
      price.toString() + " €",
      style: TextStyle(fontSize: 18.0),
    );
    final fuelTypeText = Text(
      fuelName.toString(),
      style: TextStyle(fontSize: 18),
    );

    final priceContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Center(

        child: Row(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: fuelTypeText,
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: priceContentText,
              ),
            ),
          ],
        ),
      ),
    );

    final openHourHeader =  Text("Öffnungszeiten", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,));



    final openHourContentText = Text(
      "6:00 - 22:00",
      style: TextStyle(fontSize: 18.0),
    );

    List<String> myList = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag", "Feiertage"];

    final hours = Text(
     "Montag",
      style: TextStyle(fontSize: 18),
    );

    final openHourContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Center(

        child: Row(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: hours,
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: openHourContentText,
              ),
            ),
          ],
        ),
      ),
    );


    final paymentHeader =  Text("Zahlungsmöglichkeiten", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,));



    final paymentContentText = new Container(
      child: new Column(
        children: <Widget>[
          new Text("Cash", style: TextStyle(fontSize: 18.0),),
          new Text("Credit Card", style: TextStyle(fontSize: 18.0),),
          new Text("Debit Card", style: TextStyle(fontSize: 18.0),),
        ],
      ),
    );

    final availability = new Container(
      child: new Column(
        children: <Widget>[
          new Icon(Icons.check_circle, color: Colors.green,size: 25),
          new Icon(Icons.check_circle, color: Colors.green,size: 25),
          new Icon(Icons.check_circle, color: Colors.redAccent,size: 25),
        ],
      ),
    );


    final paymentContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Center(

        child: Row(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: paymentContentText,
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: availability,
              ),
            ),

          ],
        ),

      ),
    );


    final contactHeader =  Text("Kontakt", textAlign: TextAlign.center,style: TextStyle(fontSize: 20,));



    final contactContentText = new Container(
      child: new Column(
        children: <Widget>[
          new Text("Telefon", style: TextStyle(fontSize: 18.0),),
          new Text("Mail", style: TextStyle(fontSize: 18.0),),
          new Text("Web", style: TextStyle(fontSize: 18.0),),
    ],
      ),
    );




    final info = new Container(
      child: new Column(
        children: <Widget>[
          new Text("0664 / 123456789", style: TextStyle(fontSize: 18.0),),
          new Text("office@omv.at", style: TextStyle(fontSize: 18.0),),
          new Text("www.omv.at", style: TextStyle(fontSize: 18.0),),
        ],
      ),
    );

    final contactContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Center(

        child: Row(

          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: contactContentText,
              ),
            ),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.all(10.0),
                child: info,
              ),
            ),
          ],
        ),
      ),
    );



    return Scaffold(
      appBar: AppBar(
        title: Text(name.toString()+ " Detailansicht"),
      ),
      body: Column(
        //height: 100,
        children: [addressContent,priceHeader,priceContent,openHourHeader, openHourContent,paymentHeader,paymentContent,contactHeader,contactContent],


      ),
    );
  }
}


/*
open-closeContent,addressContent,priceContent, openHoursContent,paymentContent,contactContent

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
// Image.asset("assets/images/"+name+".png",width: 600,
//   height: 240,
//   fit: BoxFit.cover,),
//Text(name.toString(),textAlign: TextAlign.center,style: const TextStyle(fontSize: 40,fontWeight: FontWeight.bold,letterSpacing: 5,shadows:[Shadow(color:Colors.black54, offset:Offset(1,2), blurRadius: 4 ) ]),),
SizedBox(height: 40),
Text("Address",textAlign:  TextAlign.left,style: const TextStyle(fontSize: 30,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 10),
Text(address.toString(),textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 40),
Text("Tankstelle",style: const TextStyle(fontSize: 30,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 10),
Text(name.toString(),textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 40),
Text("Preis",textAlign: TextAlign.center,style: const TextStyle(fontSize: 30,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 10),
Text(fuelName.toString(),textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 10),
Text(price.toString() + " €",textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 40),
Text("Entfernung",textAlign: TextAlign.center,style: const TextStyle(fontSize: 30,letterSpacing: 1,fontWeight: FontWeight.bold,fontFamily: 'Arial',fontStyle: FontStyle.normal),),
SizedBox(height: 10),
Text(distance.toString() + " km",textAlign: TextAlign.center,style: const TextStyle(fontSize: 20,letterSpacing: 1,fontWeight: FontWeight.bold, fontFamily: 'Arial',fontStyle: FontStyle.normal),),

],
)
*/

