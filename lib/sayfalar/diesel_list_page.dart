import 'package:biletinial_staj/models/basket_model.dart';
import 'package:biletinial_staj/models/diesel_price.dart';
import 'package:biletinial_staj/sayfalar/prices.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';
class DieselList extends StatefulWidget {
  const DieselList({Key? key,required this.data}) : super(key: key);

  final DieselPrice data;

  @override
  State<DieselList> createState() => _DieselListState();
}

class _DieselListState extends State<DieselList> {

  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.data.resultDiesel!.length,
        itemBuilder: (context, index) {
          print("${widget.data.resultDiesel![index].katkili} ${widget.data.resultDiesel![index].marka}");
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
                        "${widget.data.resultDiesel![index].marka}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "DM Sans"),
                      ),
                      if (widget.data.resultDiesel![index].katkili != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "1L ${widget.data.resultDiesel![index].katkili} ₺",
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
                              secilenMarka=widget.data.resultDiesel![index].marka!;
                              print(widget.data.resultDiesel![index].motorin);
                              secilenUrunFiyati=widget.data.resultDiesel![index].katkili!;
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
                              "This product is out of stock.",
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
            title: Text('Enter the number of products'),
            content: TextField(
              onChanged: (value) {
              },
              controller: _textFieldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "Enter the number of products:"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('ADD'),
                onPressed: ()async {
                  if(_textFieldController.text.isEmpty){
                    Fluttertoast.showToast(msg: "Item cannot be left blank!");
                  }
                  else if(int.parse(_textFieldController.text)<1){
                    Fluttertoast.showToast(msg: "You entered the wrong number!");
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

