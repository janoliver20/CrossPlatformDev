import 'dart:convert';

import 'dart:developer';

enum RegionType {
  bl,
  pb
}

String getRegionType(RegionType type)
{
  switch(type) {
    case RegionType.bl:
      return "BL";
    case RegionType.pb:
      return "PB";
  }
}

List<Region> regionFromJson(String str) => List<Region>.from(json.decode(str).map((x) => Region.fromJson(x)));

String regionToJson(List<Region> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Region {
  Region({
    required this.code,
    required this.regionType,
    required this.name,
    required this.subRegions,
    required this.postalCodes,
  });

  int code;
  RegionType regionType;
  String name;
  List<Region> subRegions;
  List<String> postalCodes;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    code: json["code"],
    regionType: RegionType.values.firstWhere((e) => e.toString().toLowerCase().contains(json["type"].toString().toLowerCase())),
    name: json["name"],
    subRegions: List<Region>.from(json["subRegions"].map((x) => Region.fromJson(x))),
    postalCodes: json["postalCodes"] == null ? [] : List<String>.from(json["postalCodes"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "type": getRegionType(regionType),
    "name": name,
    "subRegions": List<dynamic>.from(subRegions.map((x) => x.toJson())),
    "postalCodes": List<dynamic>.from(postalCodes.map((x) => x)),
  };
}
