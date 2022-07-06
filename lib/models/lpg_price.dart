class LpgPrice {
  bool? success;
  List<Price>? result;
  String? lastupdate;

  LpgPrice({this.success, this.result});

  LpgPrice.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    lastupdate = json['lastupdate'];
    if (json['result'] != null) {
      result = <Price>[];
      json['result'].forEach((v) {
        result!.add(new Price.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['lastupdate'] = this.lastupdate;
    return data;
  }
}

class Price {
  String? lpg;
  String? marka;

  Price({this.lpg, this.marka});

  Price.fromJson(Map<String, dynamic> json) {
    lpg = json['lpg'];
    marka = json['marka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lpg'] = this.lpg;
    data['marka'] = this.marka;
    return data;
  }
}