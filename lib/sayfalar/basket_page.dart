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
            child: ListView.builder(itemCount: _box.length,itemBuilder: (context,index){

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
                      Text("Total Price : ${_box.values.elementAt(index).piece*_box.values.elementAt(index).unit_price}",style: TextStyle(color: Colors.white))
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



                Container(
                color: Colors.grey,
                margin: EdgeInsets.all(5),
                width: 150,
                height: 150,
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${_box.values.elementAt(index).city}"),
                        Text("${_box.values.elementAt(index).brand}"),
                        Text("${_box.values.elementAt(index).type}"),
                        Text("${_box.values.elementAt(index).unit_price}"),
                        Text("${_box.values.elementAt(index).piece}"),
                        Text("Total piece = ${(_box.values.elementAt(index).piece*_box.values.elementAt(index).unit_price).toString().substring(0,4)}"),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          _box.deleteAt(index);
                        });
                      }, child:Text("Sil")),

                    ],)
                  ],
                ),
              );
            }),
          ),
        ],
      ),),
    );
  }
}
