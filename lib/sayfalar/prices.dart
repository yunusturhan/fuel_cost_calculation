import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../models/basket_model.dart';
import '../models/result_benzin.dart';


class Prices extends StatefulWidget {
  String city;

  Prices({Key? key, required this.city}) : super(key: key);

  @override
  State<Prices> createState() => _PricesState();
}

Map<String, String> header = {
  "authorization": "apikey 09vqZE5i2m8uLwY6kPJ3oz:4r662qda0w1BfwnT1iVkHY",
  "content-type": "application/json",
  "accept": "charset=UTF-8"
};

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



final Adet = [for (int i = 1; i <= 100; i++) "$i"];


String secilenSehir="";
double secilenYakitFiyati=0;
double secilenUrunFiyati=0;
String secilenYakit="Benzin";
String secilenMarka="";
class _PricesState extends State<Prices> {
  final yakitTuru = ["Benzin", "Diesel", "LPG"];

  Future<GasolinePrice> fetchPrices() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/gasPrice/turkeyGasoline?city=${widget.city}'),
        headers: header);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var elem = GasolinePrice.fromJson(jsonDecode(response.body));
      return elem;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    secilenSehir=widget.city;
    secilenYakit = "Benzin";
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 31, 41, 1),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 57,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Image.asset(
                    "assets/images/back_button.png",
                    height: 20,
                    width: 20,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Prices",
                  style: TextStyle(
                      color: Colors.white, fontSize: 20, fontFamily: "DM Sans"),
                ),
                Container(
                  width: 112,
                  height: 38,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: const Color.fromRGBO(26, 56, 72, 1)),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    value: secilenYakit,
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: const Color.fromRGBO(26, 56, 72, 1),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: yakitTuru.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(
                            items,
                            style: const TextStyle(fontSize: 12),
                          ));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        secilenYakit = newValue!;
                        if (kDebugMode) {
                          print(secilenYakit);
                        }
                      });
                    },
                  ),
                ),
              ],
            ), //Üst panel

            Expanded(
              child: FutureBuilder<GasolinePrice>(
                future: fetchPrices(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'An error has occurred!',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return CityList(cities: snapshot.data!);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CityList extends StatefulWidget {
  const CityList({Key? key, required this.cities});

  final GasolinePrice cities;

  @override
  State<CityList> createState() => _CityListState();
}

class _CityListState extends State<CityList> {

  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.cities.resultBenzin!.length,
        itemBuilder: (context, index) {
          return Container(
              width: 163,
              height: 75,
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade400),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color.fromRGBO(26, 56, 72, 1)),
              child: Center(
                  child: Column(
                children: [
                  Text(
                    "${widget.cities.resultBenzin![index].marka}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: "DM Sans"),
                  ),
                  if (widget.cities.resultBenzin![index].benzin != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "1L ${widget.cities.resultBenzin![index].benzin}\$",
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 50, 75, 1),
                              fontFamily: "DM Sans",
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontStyle: FontStyle.normal),
                        ),
                        InkWell(
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                color: Color.fromRGBO(35, 170, 73, 1)),
                            child: InkWell(
                              child: Center(
                                  child: const Icon(Icons.add,
                                      color: Colors.white, size: 16)),

                            ),
                          ),onTap: () async {
                            double fiyat =0;
                            secilenYakitFiyati=fiyat;
                            secilenMarka=widget.cities.resultBenzin![index].marka!;
                            print(widget.cities.resultBenzin![index].benzin);
                            secilenUrunFiyati=widget.cities.resultBenzin![index].benzin!;
                          _displayTextInputDialog(context);

                        }
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning_amber_outlined,
                            color: Colors.red, size: 32),
                        Text(
                          "Bu ürün stoklarda bulunmamaktadır.",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    )
                ],
              )));
        });

  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ürün Adedi Girin'),
            content: TextField(
              onChanged: (value) {
              },
              controller: _textFieldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Ürün adedi giriniz:"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('EKLE'),
                onPressed: ()async {
                  if(_textFieldController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Adedi boş geçemezsiniz!");
                  }
                  else if(int.parse(_textFieldController.text)<1){
                    Fluttertoast.showToast(msg: "Hatalı adet girdiniz!");
                  }
                  else{
                    var box = Hive.box('Basket');
                    var basket=Basket(city: '$secilenSehir',unit_price: secilenUrunFiyati,piece: double.parse(_textFieldController.text),type: secilenYakit,brand: secilenMarka);
                    bool isAdded = false;
                    for (int i = 0;i<box.values.length;i++) {
                      if(box.values.elementAt(i).city==secilenSehir && box.values.elementAt(i).type==secilenYakit &&box.values.elementAt(i).brand==secilenMarka ){
                        box.values.elementAt(i).piece+=double.parse(_textFieldController.text);
                        box.putAt(i,box.values.elementAt(i));
                        isAdded = true;
                      }
                    }

                    if(!isAdded) await box.add(basket);

                    Navigator.pop(context);
                    print("${int.parse(_textFieldController.text)}");
                  }
                },
              ),

            ],
          );
        });
  }
}
