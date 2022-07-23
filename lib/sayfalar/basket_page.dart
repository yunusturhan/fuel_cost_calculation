import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/basket_model.dart';
class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final _box =Hive.box("Basket");
  double totalprice=0;





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromRGBO(13, 31, 41, 1),
      body: Center(child: Column(
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
                "BASKET",
                style: TextStyle(
                    color: Colors.white, fontSize: 20, fontFamily: "DM Sans"),
              ),
              SizedBox(),
            ],
          ), //Üst panel
          Expanded(
            child: list_basket(),

          ),
          Container(
            width: 600,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
              color: Colors.white
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("TOTAL PRICE $totalprice")
              ],
            ),
          ),
        ],
      ),),
    );
  }

  ListView list_basket(){
    totalprice=0;

    int totalPieceLenght;
    return ListView.builder(itemCount: _box.length,itemBuilder: (context,index){

      totalPieceLenght=(_box.values.elementAt(index).piece*_box.values.elementAt(index).unit_price).toString().length;
      totalprice+=double.parse((_box.values.elementAt(index).piece*_box.values.elementAt(index).unit_price).toString().substring(0,4));
            return Card(
              shape: StadiumBorder(side: BorderSide(
                color: Colors.white,width: 1,
              )),
              color: const Color.fromRGBO(26, 56, 72, 1),
              child: ListTile(
                title: Text("${_box.values.elementAt(index).city.toUpperCase()} - ${_box.values.elementAt(index).brand} - ${_box.values.elementAt(index).type }",style: TextStyle(color: Colors.white)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Unit Price: ${_box.values.elementAt(index).unit_price}  Liter Price: ${_box.values.elementAt(index).piece}",style: TextStyle(color: Colors.white)),
                    Text("Total Price : ${(_box.values.elementAt(index).piece*_box.values.elementAt(index).unit_price).toString().substring(0,totalPieceLenght<5? totalPieceLenght:5)}",style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing: ElevatedButton(child: Text("Delete"),onPressed: (){

                  ScaffoldMessenger.of(context).showMaterialBanner(
                      MaterialBanner(
                          padding: EdgeInsets.all(20),
                          leading: Icon(Icons.warning_amber_outlined,color: Colors.red,size: 32,),
                          backgroundColor: Colors.orange,
                          content: Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text("Do you really want to delete the selected product will be removed from basket?",style: TextStyle(color: Colors.white),),

                            ],),
                          actions: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _box.deleteAt(index);
                                });

                                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                Fluttertoast.showToast(msg: "The selected product has been removed from the basket.");
                              },
                              child:Column(children: [
                                Text("Yes",style: TextStyle(color: Colors.green),),

                              ],) ,),

                            TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                              },
                              child:Column(children: [
                                Text("No",style: TextStyle(color: Colors.red),),

                              ],) ,),
                          ]));


                }),
              ),
            );

          });
  }
}
