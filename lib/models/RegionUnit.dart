import 'dart:convert';

List<RegionUnit> regionUnitFromJson(String str) =>
    List<RegionUnit>.from(json.decode(str).map((x) => RegionUnit.fromJson(x)));

String regionUnitToJson(List<RegionUnit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegionUnit {
  RegionUnit({
    this.subRegion,
    required this.code,
    required this.name,
  });

  List<States>? subRegion;
  int code;
  String name;

  factory RegionUnit.fromJson(Map<String, dynamic> json) => RegionUnit(
        subRegion: List<States>.from(json["b"].map((x) => States.fromJson(x))),
        code: json["c"],
        name: json["n"],
      );

  Map<String, dynamic> toJson() => {
        "b": List<dynamic>.from(
            subRegion?.map((x) => x.toJson()) ?? const Iterable.empty()),
        "c": code,
        "n": name,
      };
}

class States {
  States({
    required this.code,
    this.subRegion,
    required this.name,
  });

  int code;
  List<Municipality>? subRegion;
  String name;

  factory States.fromJson(Map<String, dynamic> json) => States(
        code: json["c"],
        subRegion: List<Municipality>.from(
            json["g"].map((x) => Municipality.fromJson(x))),
        name: json["n"],
      );

  Map<String, dynamic> toJson() => {
        "c": code,
        "g": List<dynamic>.from(
            subRegion?.map((x) => x.toJson()) ?? const Iterable.empty()),
        "n": name,
      };
}

class Municipality {
  Municipality({
    required this.lat,
    required this.long,
    required this.name,
    required this.postal,
  });

  double lat;
  double long;
  String name;
  String postal;

  factory Municipality.fromJson(Map<String, dynamic> json) => Municipality(
        lat: json["b"],
        long: json["l"],
        name: json["n"],
        postal: json["p"],
      );

  Map<String, dynamic> toJson() => {
        "b": lat,
        "l": long,
        "n": name,
        "p": postal,
      };
}
