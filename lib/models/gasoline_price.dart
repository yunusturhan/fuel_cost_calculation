import 'package:biletinial_staj/models/result_gasolin.dart';

class GasolinePrice {
  bool? success;
  List<ResultBenzin>? resultBenzin;

  GasolinePrice({this.success, this.resultBenzin});

  GasolinePrice.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['result'] != null) {
      resultBenzin = <ResultBenzin>[];
      json['result'].forEach((v) {
        resultBenzin!.add(new ResultBenzin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.resultBenzin != null) {
      data['result'] = this.resultBenzin!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
