import 'dart:convert';

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
    this.cities,
    required this.code,
    required this.name,
    this.postalCodes,
    this.subRegions,
    required this.regionType,
  });

  List<String>? cities;
  int code;
  String name;
  List<String>? postalCodes;
  List<dynamic>? subRegions;
  RegionType regionType;

  factory Region.fromJson(Map<String, dynamic> json) => Region(
    cities: List<String>.from(json["cities"].map((x) => x)),
    code: json["code"],
    name: json["name"],
    postalCodes: List<String>.from(json["postalCodes"].map((x) => x)),
    subRegions: List<dynamic>.from(json["subRegions"].map((x) => x)),
    regionType: RegionType.values.firstWhere((e) => e.toString() == json["type"].toString().toLowerCase())
  );

  Map<String, dynamic> toJson() => {
    "cities": List<dynamic>.from(cities?.map((x) => x) ?? const Iterable.empty()),
    "code": code,
    "name": name,
    "postalCodes": List<dynamic>.from(postalCodes?.map((x) => x) ?? const Iterable.empty()),
    "subRegions": List<dynamic>.from(subRegions?.map((x) => x) ?? const Iterable.empty()),
    "type": getRegionType(regionType),
  };
}
