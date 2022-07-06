import 'package:biletinial_staj/models/result_diesel.dart';

class DieselPrice {
  bool? success;
  List<ResultDiesel>? resultDiesel;

  DieselPrice({this.success, this.resultDiesel});

  DieselPrice.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      resultDiesel = <ResultDiesel>[];
      json['result'].forEach((v) {
        resultDiesel!.add(new ResultDiesel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.resultDiesel != null) {
      data['result'] = this.resultDiesel!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}