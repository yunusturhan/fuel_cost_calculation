import 'package:biletinial_staj/sayfalar/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'auth_controller.dart';
import 'constants.dart';
import 'models/basket_model.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(BasketAdapter());
  await Hive.openBox('Basket');
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(13, 31, 41, 1),
      ),
      home: const CircularProgressIndicator(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async{
    print("Waiting");
    await Future.delayed(Duration(seconds: 2)).then((value){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Anasayfa()),
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/splash_logo.png",width: 110,height: 110,),
      ),
    );
  }
}
