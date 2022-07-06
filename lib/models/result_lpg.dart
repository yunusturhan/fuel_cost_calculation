class ResultLpg {
  double? lpg;
  String? marka;

  ResultLpg({this.lpg, this.marka});

  ResultLpg.fromJson(Map<String, dynamic> json) {
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