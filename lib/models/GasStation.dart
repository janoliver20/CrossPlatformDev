// To parse this JSON data, do
//
//     final gasStation = gasStationFromJson(jsonString);

import 'dart:convert';

import 'dart:developer';

enum FuelType {
  die,
  sup,
  gas
}

String getFuelType(FuelType type)
 {
  switch(type) {
    case FuelType.sup:
      return "SUP";
    case FuelType.gas:
      return "GAS";
    case FuelType.die:
      return "DIE";
  }
}
List<GasStation> gasStationFromJson(String str) => List<GasStation>.from(json.decode(str).map((x) => GasStation.fromJson(x)));

String gasStationToJson(List<GasStation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GasStation {
  GasStation({
    this.contact,
    this.distance,
    required this.id,
    required this.location,
    required this.name,
    required this.offerInformation,
    this.open,
    required this.openingHours,
    this.otherServiceOffers,
    this.paymentArrangements,
    required this.paymentMethods,
    this.position,
    required this.prices,
  });

  Contact? contact;
  double? distance;
  int id;
  Location location;
  String name;
  OfferInformation offerInformation;
  bool? open;
  List<OpeningHour> openingHours = [];
  String? otherServiceOffers;
  PaymentArrangements? paymentArrangements;
  PaymentMethods paymentMethods;
  int? position;
  List<Price> prices = [];

  factory GasStation.fromJson(Map<String, dynamic> json) => GasStation(
    contact: Contact.fromJson(json["contact"]),
    distance: json["distance"],
    id: json["id"],
    location: Location.fromJson(json["location"]),
    name: json["name"],
    offerInformation: OfferInformation.fromJson(json["offerInformation"]),
    open: json["open"],
    openingHours: List<OpeningHour>.from(json["openingHours"].map((x) => OpeningHour.fromJson(x))),
    otherServiceOffers: json["otherServiceOffers"],
    paymentArrangements: PaymentArrangements.fromJson(json["paymentArrangements"]),
    paymentMethods: PaymentMethods.fromJson(json["paymentMethods"]),
    position: json["position"],
    prices: json.containsKey("prices") ? List<Price>.from(json["prices"].map((x) => Price.fromJson(x))) : [],
  );

  Map<String, dynamic> toJson() => {
    "contact": contact?.toJson(),
    "distance": distance,
    "id": id,
    "location": location.toJson(),
    "name": name,
    "offerInformation": offerInformation.toJson(),
    "open": open,
    "openingHours": List<dynamic>.from(openingHours.map((x) => x.toJson())),
    "otherServiceOffers": otherServiceOffers,
    "paymentArrangements": paymentArrangements?.toJson(),
    "paymentMethods": paymentMethods.toJson(),
    "position": position,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
  };
}

class Contact {
  Contact({
    this.fax,
    this.mail,
    this.telephone,
    this.website,
  });

  String? fax;
  String? mail;
  String? telephone;
  String? website;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    fax: json["fax"],
    mail: json["mail"],
    telephone: json["telephone"],
    website: json["website"],
  );

  Map<String, dynamic> toJson() => {
    "fax": fax,
    "mail": mail,
    "telephone": telephone,
    "website": website,
  };
}

class Location {
  Location({
    required this.address,
    required this.city,
    required this.latitude,
    required this.longitude,
    required this.postalCode,
  });

  String address;
  String city;
  double latitude;
  double longitude;
  String postalCode;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    address: json["address"],
    city: json["city"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    postalCode: json["postalCode"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "city": city,
    "latitude": latitude,
    "longitude": longitude,
    "postalCode": postalCode,
  };
}

class OfferInformation {
  OfferInformation({
    required this.selfService,
    required this.service,
    required this.unattended,
  });

  bool selfService;
  bool service;
  bool unattended;

  factory OfferInformation.fromJson(Map<String, dynamic> json) => OfferInformation(
    selfService: json["selfService"],
    service: json["service"],
    unattended: json["unattended"],
  );

  Map<String, dynamic> toJson() => {
    "selfService": selfService,
    "service": service,
    "unattended": unattended,
  };
}

class OpeningHour {
  OpeningHour({
    required this.day,
    required this.from,
    required this.to,
  });

  String day;
  String from;
  String to;

  factory OpeningHour.fromJson(Map<String, dynamic> json) => OpeningHour(
    day: json["day"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "from": from,
    "to": to,
  };
}

class PaymentArrangements {
  PaymentArrangements({
    this.accessMod,
    this.clubCard,
    this.clubCardText,
    this.cooperative,
  });

  String? accessMod;
  bool? clubCard;
  String? clubCardText;
  bool? cooperative;

  factory PaymentArrangements.fromJson(Map<String, dynamic> json) => PaymentArrangements(
    accessMod: json["accessMod"],
    clubCard: json["clubCard"],
    clubCardText: json["clubCardText"],
    cooperative: json["cooperative"],
  );

  Map<String, dynamic> toJson() => {
    "accessMod": accessMod,
    "clubCard": clubCard,
    "clubCardText": clubCardText,
    "cooperative": cooperative,
  };
}

class PaymentMethods {
  PaymentMethods({
    required this.cash,
    required this.creditCard,
    required this.debitCard,
    this.others,
  });

  bool cash;
  bool creditCard;
  bool debitCard;
  String? others;

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => PaymentMethods(
    cash: json["cash"],
    creditCard: json["creditCard"],
    debitCard: json["debitCard"],
    others: json["others"],
  );

  Map<String, dynamic> toJson() => {
    "cash": cash,
    "creditCard": creditCard,
    "debitCard": debitCard,
    "others": others,
  };
}

class Price {
  Price({
    required this.amount,
    required this.fuelType,
    required this.label,
  });

  double amount;
  FuelType fuelType;
  String label;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    amount: json["amount"],
    fuelType: FuelType
        .values
        .firstWhere((e) => e.toString().toLowerCase().contains(json["fuelType"].toString().toLowerCase())),
    label: json["label"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "fuelType": getFuelType(fuelType),
    "label": label,
  };
}
