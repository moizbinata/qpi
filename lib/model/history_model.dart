import 'dart:convert';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(
    json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  HistoryModel({
    this.id,
    this.name,
    this.orderdate,
    this.deliverytime,
    this.ordetails,
    this.location,
    this.price,
    this.bstatus,
    this.thumbnail,
  });

  String id;
  String name;
  String orderdate;
  String deliverytime;
  String ordetails;
  String location;
  int price;
  String bstatus;
  String thumbnail;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        name: json["name"],
        orderdate: json["orderdate"],
        deliverytime: json["deliverytime"],
        ordetails: json["ordetails"],
        location: json["location"],
        price: json["price"],
        bstatus: json["bstatus"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "orderdate": orderdate,
        "deliverytime": deliverytime,
        "ordetails": ordetails,
        "location": location,
        "price": price,
        "bstatus": bstatus,
        "thumbnail": thumbnail,
      };
}

// enum Bstatus { CREATED }

// final bstatusValues = EnumValues({"Created": Bstatus.CREATED});

// enum Name { MALA }

// final nameValues = EnumValues({"Mala--": Name.MALA});

// class EnumValues<T> {
//   Map<String, T> map;
//   Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     if (reverseMap == null) {
//       reverseMap = map.map((k, v) => new MapEntry(v, k));
//     }
//     return reverseMap;
//   }
// }
