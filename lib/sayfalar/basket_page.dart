import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
      appBar: AppBar(title: Center(child: Text("Basket"),),),
      body: Center(child: ListView.builder(itemCount: _box.length,itemBuilder: (context,index){

        String a="asdfdas";
        a.toUpperCase();

        return Card(
          color: Colors.green.shade400,
          child: ListTile(
            title: Text("${_box.values.elementAt(index).city.toUpperCase()} - ${_box.values.elementAt(index).brand}"),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Birim Fiyatı: ${_box.values.elementAt(index).unit_price}  Litre Fiyatı: ${_box.values.elementAt(index).piece}"),
                Text("Toplam Tutar : ${(_box.values.elementAt(index).piece*_box.values.elementAt(index).unit_price).toString().substring(0,4)}")
              ],
            ),
            trailing: ElevatedButton(child: Text("Sil"),onPressed: (){
              setState(() {
                _box.deleteAt(index);
              });
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
      }),),
    );
  }
}
