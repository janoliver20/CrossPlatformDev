import 'package:flutter/cupertino.dart';
import 'package:Me_Fuel/scrollView.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';




class DetailPage extends StatelessWidget {

  var name, price, distance, address, fuelName, long,lat,dayOpen,payment,contact, postalcode, city;


  DetailPage(
      {this.name, this.price, this.distance, this.address, this.fuelName, this.long, this.lat,this.dayOpen,this.payment,this.contact, this.postalcode,  this.city});


  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 45.0),
        address.toString().length > 25 ?
    Text(
    address.toString().substring(0,25)+"...",
    style: TextStyle(color: Colors.white, fontSize: 18.0),
    ) :
    Text(
    address.toString(),
    style: TextStyle(color: Colors.white, fontSize: 18.0),),

       Text(postalcode.toString() + " " + city.toString() ,
          style: TextStyle(color: Colors.white),),

        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.directions_car,
              color: Colors.white,
              size: 18.0,
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
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/map_test_detail.JPG"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery
              .of(context)
              .size
              .width,
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
              print("To Google Maps ");
              print(long);
              print(lat);
              MapUtils.openMap(long, lat);
            },
            child: Icon(Icons.assistant_navigation, color: Colors.green, size: 45),
          ),
        ),

      ],
    );



    final priceContentText =
    price.toString().isNotEmpty ?
         Text(
              fuelName.toString()+ "                " + price.toString() + " €",
              style: TextStyle(fontSize: 18.0),
            ):
    Text(
      "Kein Preis verfügbar",
      style: TextStyle(fontSize: 18.0),
    );



    final priceContent = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      ExpansionTile(
                        title: Text(
                          "Preise",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        children: <Widget>[

                          ListTile(
                            title: priceContentText,
                          ),


                        ],

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );







    final openHourContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      ExpansionTile(
                        title: Text(
                          "Öffnungszeiten",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        children: <Widget>[

                          ListTile(
                            title: Text(
                                dayOpen[0].day +"            "+ dayOpen[0].from + "-" + dayOpen[0].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[1].day +"              "+ dayOpen[1].from + "-" + dayOpen[1].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[2].day +"             "+ dayOpen[2].from + "-" + dayOpen[2].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[3].day +"            "+ dayOpen[3].from + "-" + dayOpen[3].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[4].day +"            "+ dayOpen[4].from + "-" + dayOpen[4].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[5].day +"            "+ dayOpen[5].from + "-" + dayOpen[5].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[6].day +"            "+ dayOpen[6].from + "-" + dayOpen[6].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                dayOpen[7].day +"             "+ dayOpen[7].from + "-" + dayOpen[7].to
                            ),
                          ),
                        ],

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],

      ),
    );



    final paymentContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      ExpansionTile(
                        title: Text(
                          "Zahlungsmöglichkeiten",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        children: <Widget>[

                          ListTile(

                            title: Text(
                                'Bar'
                            ),
                            leading: payment.cash == true ?
                            const Icon(Icons.check_circle, color: Colors.green, size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red, size: 25),


                          ),
                          ListTile(
                            title: Text(
                                'Bankkarte'
                            ),
                            leading: payment.creditCard == true ?
                            const Icon(Icons.check_circle, color: Colors.green, size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red, size: 25),
                          ),
                          ListTile(
                            title: Text(
                                'Kreditkarte'
                            ),
                            leading: payment.debitCard == true ?
                            const Icon(Icons.check_circle, color: Colors.green, size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red, size: 25),
                          ),

                        ],

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );


    final contactContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(15.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      ExpansionTile(
                        title: Text(
                          "Kontakt",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        children: <Widget>[

                          ListTile(
                            title: contact.telephone.toString() == "null" ? Text(
                                'Telefon:  nicht vorhanden '
                            ) :
                            Text(
                                'Telefon:  +' + contact.telephone.toString()
                            ),
                          ),
                          ListTile(
                            title: contact.mail.toString() == "null" ? Text(
                                'Mail:  nicht vorhanden'
                            ) :
                            Text(
                                'Mail:  ' + contact.mail.toString()
                            ),
                          ),
                          ListTile(
                            title: contact.website.toString() == "null" ? Text(
                                'Web:  nicht vorhanden'
                            ) :
                            Text(
                                'Web:  ' + contact.website.toString()
                            ),
                          ),

                        ],

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      ),
    );


    return Scaffold(

      appBar: AppBar(
        title: Text(name.toString() + " Detailansicht"),
      ),

      body: SingleChildScrollView(

          child: price.toString().isNotEmpty ? Column(
        //height: 100,
            children: [
              addressContent,
              priceContent,
              openHourContent,
              paymentContent,
              contactContent
            ],


      ) :
          Column(
            //height: 100,
            children: [
              addressContent,
              priceContent,
              openHourContent,
              paymentContent,
              contactContent
            ],


          ),
      ),
    );
  }

}


class MapUtils {

  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {

    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$longitude,$latitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}