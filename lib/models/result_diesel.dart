class ResultDiesel {
  double? katkili;
  double? motorin;
  String? marka;

  ResultDiesel({this.katkili, this.motorin, this.marka});

  ResultDiesel.fromJson(Map<String, dynamic> json) {
    katkili = json['katkili'];
    motorin = json['motorin'];
    marka = json['marka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['katkili'] = this.katkili;
    data['motorin'] = this.motorin;
    data['marka'] = this.marka;
    return data;
  }
}