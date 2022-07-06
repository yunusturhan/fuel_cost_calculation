import 'dart:convert';
import 'package:biletinial_staj/models/diesel_price.dart';
import 'package:biletinial_staj/sayfalar/diesel_list_page.dart';
import 'package:biletinial_staj/sayfalar/gasoline_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/gasoline_price.dart';
import '../models/lpg_price.dart';
import 'lpg_list_page.dart';

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

String secilenSehir="";
double secilenYakitFiyati=0;
double secilenUrunFiyati=0;
String secilenYakit="Benzin";
String secilenMarka="";
class _PricesState extends State<Prices> {
  final yakitTuru = ["Benzin", "Diesel", "LPG"];

  Future<GasolinePrice> fetchPricesGasoline() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/gasPrice/turkeyGasoline?city=${widget.city}'),
        headers: header);

    if (response.statusCode == 200) {
      var elem = GasolinePrice.fromJson(jsonDecode(response.body));
      return elem;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<DieselPrice> fetchPricesDiesel() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/gasPrice/turkeyDiesel?city=${widget.city}'),
        headers: header);

    if (response.statusCode == 200) {
      var elem = DieselPrice.fromJson(jsonDecode(response.body));
      return elem;
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<LpgPrice> fetchPricesLpg() async {
    final response = await http.get(
        Uri.parse(
            'https://api.collectapi.com/gasPrice/turkeyLpg?city=${widget.city}'),
        headers: header);

    if (response.statusCode == 200) {
      var elem = LpgPrice.fromJson(jsonDecode(response.body));
      return elem;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    secilenSehir=widget.city;
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

                      });
                    },
                  ),
                ),
              ],
            ), //Üst panel

            if(secilenYakit=="Benzin")
              Expanded(
                child: FutureBuilder<GasolinePrice>(
                  future: fetchPricesGasoline(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'An error has occurred!',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return GasolinList(data: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            if(secilenYakit=="Diesel")
              Expanded(
                child: FutureBuilder<DieselPrice>(
                  future: fetchPricesDiesel(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'An error has occurred!',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return DieselList(data: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            if(secilenYakit=="LPG")
              Expanded(
                child: FutureBuilder<LpgPrice>(
                  future: fetchPricesLpg(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          'An error has occurred!',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return LpgList(data: snapshot.data!);
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


