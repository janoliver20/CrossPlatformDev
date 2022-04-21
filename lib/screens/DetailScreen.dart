import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/screens/GasStationListScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Strings.dart';




class DetailScreen extends StatelessWidget {

  GasStation gasStation;

  DetailScreen({required this.gasStation});


  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 45.0),
        Text(
          gasStation.location.address.toString().truncate(25),
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
       Text(
         gasStation.location.postalCode.toString() + " " + gasStation.location.city.toString() ,
          style: const TextStyle(color: Colors.white),
       ),

        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Icons.directions_car,
              color: Colors.white,
              size: 18.0,
            ),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      gasStation.distance?.toString() ?? "-" + " km",
                      style: const TextStyle(color: Colors.white),
                    ))),
          ],
        ),
      ],
    );

    final addressContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.3,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/map_test_detail.JPG"),
                fit: BoxFit.cover,
              ),
            )
        ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.3,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(color: const Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          right: 30.0,
          bottom: 30.0,
          child: InkWell(
            onTap: () {
              MapUtils.openMap(gasStation.location.longitude, gasStation.location.latitude);
            },
            child: const Icon(Icons.assistant_navigation, color: Colors.green, size: 45),
          ),
        ),
      ],
    );

    final priceContentText =
    gasStation.prices.isNotEmpty ?
         Text(
              getFuelType().toString()+ "                " + gasStation.prices[0].amount.toString() + " €/l",
              style: const TextStyle(fontSize: 18.0),
            ) :
        const Text(
          Strings.gasStationDetail_noPrices,
          style: TextStyle(fontSize: 18.0),
        );


    final priceContent = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(15.0),

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
                      const SizedBox(height: 20.0),
                      ExpansionTile(
                        title: const Text(
                          Strings.gasStationDetail_prices_title,
                          style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold ),
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
      padding: const EdgeInsets.all(15.0),

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
                      const SizedBox(height: 20.0),
                      ExpansionTile(
                        title: const Text(
                          Strings.gasStationDetail_openingHours_title,
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        children: <Widget>[

                          ListTile(
                            title: Text(
                                gasStation.openingHours[0].day
                            ),
                            trailing: Text(
                                gasStation.openingHours[0].from + "-" + gasStation.openingHours[0].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[1].day +"              "+ gasStation.openingHours[1].from + "-" + gasStation.openingHours[1].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[2].day +"             "+ gasStation.openingHours[2].from + "-" + gasStation.openingHours[2].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[3].day +"            "+ gasStation.openingHours[3].from + "-" + gasStation.openingHours[3].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[4].day +"            "+ gasStation.openingHours[4].from + "-" + gasStation.openingHours[4].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[5].day +"            "+ gasStation.openingHours[5].from + "-" + gasStation.openingHours[5].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[6].day +"            "+ gasStation.openingHours[6].from + "-" + gasStation.openingHours[6].to
                            ),
                          ),
                          ListTile(
                            title: Text(
                                gasStation.openingHours[7].day +"             "+ gasStation.openingHours[7].from + "-" + gasStation.openingHours[7].to
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
      padding: const EdgeInsets.all(15.0),

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
                        title: const Text(
                          Strings.gasStationDetail_paymentMethods_title,
                          style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold ),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Text( Strings.gasStationDetail_paymentMethods_cash ),
                            leading: gasStation.paymentMethods.cash == true ?
                            const Icon(Icons.check_circle, color: Colors.green, size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red, size: 25),
                          ),
                          ListTile(
                            title: Text( Strings.gasStationDetail_paymentMethods_creditCard ),
                            leading: gasStation.paymentMethods.creditCard == true ?
                            const Icon(Icons.check_circle, color: Colors.green, size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red, size: 25),
                          ),
                          ListTile(
                            title: Text( Strings.gasStationDetail_paymentMethods_debitCard ),
                            leading: gasStation.paymentMethods.debitCard == true ?
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
      padding: const EdgeInsets.all(15.0),

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
                        title: const Text(
                          "Kontakt",
                          style: TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold ),
                        ),
                        children: <Widget>[

                          ListTile(
                            title: gasStation.contact?.telephone.toString() == "null" ? const Text(
                                'Telefon:  nicht vorhanden '
                            ) :
                            Text(
                                'Telefon:  +' + gasStation.contact!.telephone.toString()
                            ),
                          ),
                          ListTile(
                            title: gasStation.contact?.mail.toString() == "null" ? const Text(
                                'Mail:  nicht vorhanden'
                            ) :
                            Text(
                                'Mail:  ' + gasStation.contact!.mail.toString()
                            ),
                          ),
                          ListTile(
                            title: gasStation.contact?.website.toString() == "null" ? const Text(
                                'Web:  nicht vorhanden'
                            ) :
                            Text(
                                'Web:  ' + gasStation.contact!.website.toString()
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
        title: Text(gasStation.name.toString()),
      ),

      body: SingleChildScrollView(
        child:
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

  String getFuelType(){
    String fuelType = gasStation.prices[0].fuelType.toString();

    if(fuelType == "FuelType.die"){
      return "Diesel: ";
    } else  if(fuelType == "FuelType.sup"){
      return "Super: ";
    } else  if(fuelType == "FuelType.gas"){
      return "Gas: ";
    }
    return "-";
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