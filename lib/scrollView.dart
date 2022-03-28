
import 'dart:developer';

import 'package:Me_Fuel/HomePage.dart';
import 'package:Me_Fuel/detailPage.dart';
import 'package:flutter/material.dart';

// suche, filter,

class ListViewHome extends StatelessWidget {
  var gasStations = ["OMV", "Shell", "Lagerhaus", "Turmöl"];
  var prices = [2.2345, 1.4334, 2.1235, 1.9456];
  var disdance = [1.4, 2.5, 4.7, 4.6];


  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tankstellen'),

        ),
        body: CustomScrollView(
          slivers: <Widget>[

            SliverList(

                delegate: SliverChildListDelegate(
                    [
                      for(var i = 0; i <= gasStations.length - 1; i++)
                        ListTile(
                          leading: CircleAvatar(radius: 30,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(child: Image.asset(
                                "assets/images/" + gasStations[i] + ".png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,),
                              )
                          ),
                          //backgroundColor: Colors.black,
                          title: Text(gasStations[i],
                              style: const TextStyle(fontSize: 27)),
                          subtitle: Text(prices[i].toString(),
                              style: const TextStyle(fontSize: 17)),
                          trailing: Wrap(
                            spacing: 12, // space between two icons
                            children: <Widget>[
                              Text(disdance[i].toString() + " km",), // Text
                              Icon(Icons.star), // icon
                            ],
                          ),
                          //onTap: onTapEvent(context)
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return HomePage();
                                  /*return DetailPage(
                                    name: gasStations[i],
                                    price: prices[i],
                                    distance: disdance[i],
                                  );*/
                                })
                              //MaterialPageRoute(builder: (context) => const DetailPage()),
                            );
                          },
                        )

                    ]
                )
            )

          ],
        ));
  }

  void onTapEvent() {

  }
}
