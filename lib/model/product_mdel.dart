import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    this.productid,
    this.servicename,
    this.price,
    this.slot1,
    this.slot2,
    this.slot3,
    this.slot4,
    this.slot5,
    this.slot1Price,
    this.slot2Price,
    this.slot3Price,
    this.slot4Price,
    this.slot5Price,
    this.orgrice,
    this.proddesc,
    this.usageunit,
    this.discount,
    this.category,
    this.catg,
    this.url,
  });

  String productid;
  String servicename;
  String price;
  String slot1;
  String slot2;
  String slot3;
  String slot4;
  String slot5;
  String slot1Price;
  String slot2Price;
  String slot3Price;
  String slot4Price;
  String slot5Price;
  String orgrice;
  String proddesc;
  Usageunit usageunit;
  dynamic discount;
  String category;
  String catg;
  String url;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productid: json["productid"],
        servicename: json["servicename"],
        price: json["price"],
        slot1: json["slot1"],
        slot2: json["slot2"],
        slot3: json["slot3"],
        slot4: json["slot4"],
        slot5: json["slot5"],
        slot1Price: json["slot1price"],
        slot2Price: json["slot2price"],
        slot3Price: json["slot3price"],
        slot4Price: json["slot4price"],
        slot5Price: json["slot5price"],
        orgrice: json["orgrice"],
        proddesc: json["proddesc"],
        usageunit: usageunitValues.map[json["usageunit"]],
        discount: json["discount"],
        category: json["category"],
        catg: json["catg"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "productid": productid,
        "servicename": servicename,
        "price": price,
        "slot1": slot1,
        "slot2": slot2,
        "slot3": slot3,
        "slot4": slot4,
        "slot5": slot5,
        "slot1price": slot1Price,
        "slot2price": slot2Price,
        "slot3price": slot3Price,
        "slot4price": slot4Price,
        "slot5price": slot5Price,
        "orgrice": orgrice,
        "proddesc": proddesc,
        "usageunit": usageunitValues.reverse[usageunit],
        "discount": discount,
        "category": category,
        "catg": catg,
        "url": url,
      };
}

enum Usageunit { THE_1_KG }

final usageunitValues = EnumValues({"1 KG": Usageunit.THE_1_KG});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
