class ResultBenzin {
  dynamic katkili;
  double? benzin;
  String? marka;

  ResultBenzin({this.katkili, this.benzin, this.marka});

  ResultBenzin.fromJson(Map<String, dynamic> json) {
    katkili = json['katkili'];
    benzin = json['benzin'];
    marka = json['marka'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['katkili'] = this.katkili;
    data['benzin'] = this.benzin;
    data['marka'] = this.marka;
    return data;
  }
}