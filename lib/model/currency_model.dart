import 'dart:convert';
import 'package:hive/hive.dart';
part 'currency_model.g.dart';

List<CurrencyModel> currencyModelFromJson(String str) =>
    List<CurrencyModel>.from(
        json.decode(str).map((x) => CurrencyModel.fromJson(x)));

String currencyModelToJson(List<CurrencyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class CurrencyModel {
  CurrencyModel({
    required this.title,
    required this.code,
    required this.cbPrice,
    required this.nbuBuyPrice,
    required this.nbuCellPrice,
    required this.date,
  });
  @HiveField(0)
  String title;
  @HiveField(1)
  String code;
  @HiveField(2)
  String cbPrice;
  @HiveField(3)
  String nbuBuyPrice;
  @HiveField(4)
  String nbuCellPrice;
  @HiveField(5)
  Date? date;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        title: json["title"],
        code: json["code"],
        cbPrice: json["cb_price"],
        nbuBuyPrice: json["nbu_buy_price"],
        nbuCellPrice: json["nbu_cell_price"],
        date: dateValues.map[json["date"]],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "code": code,
        "cb_price": cbPrice,
        "nbu_buy_price": nbuBuyPrice,
        "nbu_cell_price": nbuCellPrice,
        "date": dateValues.reverse[date],
      };
}

enum Date { THE_18052022160001 }

final dateValues = EnumValues({"18.05.2022 16:00:01": Date.THE_18052022160001});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
