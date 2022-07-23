import 'package:flutter/material.dart';
import 'package:biletinial_staj/auth_controller.dart';
import 'package:get/get.dart';
class History extends StatefulWidget {
  History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  AuthController instance = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child: Text("History"),),),
      body: Center(
        child: Column(
          children: [
            Text("${instance.firebaseUser.value?.email}"),
          ],
        ),
      ),
    );
  }
}
