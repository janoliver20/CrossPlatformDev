import 'package:Me_Fuel/models/GasStation.dart';
import 'package:Me_Fuel/screens/GasStationListScreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Strings.dart';


class DetailScreen extends StatelessWidget {

  GasStation gasStation;

  DetailScreen({Key? key, required this.gasStation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          gasStation.location.address.toString().truncate(25),
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        const SizedBox(height: 4.0),
        Text(
          gasStation.location.postalCode.toString() + " " +
              gasStation.location.city.toString(),
          style: const TextStyle(color: Colors.white),
        ),

        const SizedBox(height: 4.0),
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
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      (gasStation.distance?.toStringAsFixed(2) ?? "-") + " km",
                      style: const TextStyle(color: Colors.white),
                    )
                )
            ),
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
          decoration: const BoxDecoration(
              color: Color.fromRGBO(58, 66, 86, .9)),
        ),
        Positioned(
          left: 16.0,
          bottom: 16.0,
          height: 65,
          width: 250,
          child: Container(
            child: topContentText,
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 16.0,
          child: InkWell(
            onTap: () {
              MapUtils.openMap(
                  gasStation.location.latitude, gasStation.location.longitude);
            },
            child: const Icon(
                Icons.assistant_navigation, color: Colors.white, size: 45),
          ),
        ),
      ],
    );

    final priceContentText = gasStation.prices.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: gasStation.prices.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(getFuelTypeName(gasStation.prices[index].fuelType),
                style: const TextStyle(fontSize: 18.0)),
            trailing: Text(gasStation.prices[index].amount.toString() + " €/l",
                style: const TextStyle(fontSize: 18.0)),
          );
        }) : const Text(
        Strings.gasStationDetail_noPrices, style: TextStyle(fontSize: 18.0));

    final priceContent = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: const Text(
                          Strings.gasStationDetail_prices_title,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        children: [
                          priceContentText
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
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: const Text(
                        Strings.gasStationDetail_openingHours_title,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            itemExtent: 32,
                            itemCount: gasStation.openingHours.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Text(
                                    gasStation.openingHours[index].day),
                                trailing: Text(
                                    gasStation.openingHours[index].from + "-" +
                                        gasStation.openingHours[index].to),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                dense: true,
                              );
                            })
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final paymentContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: const Text(
                          Strings.gasStationDetail_paymentMethods_title,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: const Text(
                                Strings.gasStationDetail_paymentMethods_cash),
                            leading: gasStation.paymentMethods.cash == true ?
                            const Icon(Icons.check_circle, color: Colors.green,
                                size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red,
                                size: 25),
                          ),
                          ListTile(
                            title: const Text(Strings
                                .gasStationDetail_paymentMethods_creditCard),
                            leading: gasStation.paymentMethods.creditCard ==
                                true ?
                            const Icon(Icons.check_circle, color: Colors.green,
                                size: 25) :
                            const Icon(Icons.do_not_disturb, color: Colors.red,
                                size: 25),
                          ),
                          ListTile(
                            title: const Text(Strings
                                .gasStationDetail_paymentMethods_debitCard),
                            leading: gasStation.paymentMethods.debitCard == true
                                ?
                            const Icon(Icons.check_circle, color: Colors.green,
                                size: 25)
                                :
                            const Icon(Icons.do_not_disturb, color: Colors.red,
                                size: 25),
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
      width: MediaQuery
          .of(context)
          .size
          .width,
      // color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: const Text(
                          Strings.gasStationDetail_contact_title,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        children: <Widget>[
                          ListTile(
                            leading: const Text(
                                Strings.gasStationDetail_contact_telephone),
                            trailing: gasStation.contact?.telephone == null
                                ? const Text("-")
                                : Text(
                                gasStation.contact!.telephone.toString()),
                          ),
                          ListTile(
                            leading: const Text(
                                Strings.gasStationDetail_contact_mail),
                            trailing: gasStation.contact?.mail == null
                                ? const Text("-")
                                : Text(gasStation.contact!.mail.toString()),
                          ),
                          ListTile(
                            leading: const Text(
                                Strings.gasStationDetail_contact_web),
                            trailing: gasStation.contact?.website == null
                                ? const Text("-")
                                : Text(gasStation.contact!.website.toString()),
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
}

class MapUtils {
  MapUtils._();

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'comgooglemaps://?daddr=$latitude,$longitude';
    String appleMapsUrl = 'http://maps.apple.com/?daddr=$latitude,$longitude&dirflg=d&t=h';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}