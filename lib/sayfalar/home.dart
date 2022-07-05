import 'dart:convert';
import 'package:biletinial_staj/sayfalar/basket_page.dart';
import 'package:biletinial_staj/sayfalar/prices.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

String link="https://gist.githubusercontent.com/ozdemirburak/4821a26db048cc0972c1beee48a408de/raw/4754e5f9d09dade2e6c461d7e960e13ef38eaa88/cities_of_turkey.json";


Future<List<City>> fetchCity(http.Client client) async {
  final response = await client
      .get(Uri.parse(link));

  return compute(parseCity, response.body);
}

List<City> parseCity(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<City>((json) => City.fromJson(json)).toList();
}

class City {
  final int id;
  final String name;

  const City({
    required this.id,
    required this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}



class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(13, 31, 41, 1),

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 57,),
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(),
                const Text("Cities",style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "DM Sans"),),
                InkWell(child: Image.asset("assets/images/basket.png",height: 20,width: 20,),onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BasketPage()));
                  print("Basket is clicked");},)
              ],
            ),
            SizedBox(height: 50,),
            Expanded(
              child: FutureBuilder<List<City>>(
                future: fetchCity(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('An error has occurred!'),
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

class CityList extends StatelessWidget {
  const CityList({Key? key, required this.cities});

  final List<City> cities;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,childAspectRatio: 2,crossAxisSpacing: 20,mainAxisSpacing: 20
      ),
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            print("${cities[index].name}");
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Prices(city:cities[index].name.toLowerCase() )));
          },
          child: Container(
            width: 163,
            height: 53,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Colors.grey.shade400),
                borderRadius: BorderRadius.all(
                    Radius.circular(20)),
                color: Color.fromRGBO(
                    26, 56, 72, 1)),
              child: Center(child: Text("${cities[index].name}",style: TextStyle(color: Colors.white),))),
        );
      },
    );
  }
}
