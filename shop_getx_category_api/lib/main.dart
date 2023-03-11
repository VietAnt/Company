import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_getx_category_api/controllers/auth/auth_controller.dart';
import 'package:shop_getx_category_api/pages/home_cart/home.dart';
import 'package:shop_getx_category_api/pages/splash/splash.dart';

AuthController authController = AuthController();

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Obx(
        () {
          if (authController.authenicated.value)
            return HomeView();
          else
            return SplashScreen();
        },
      ),
    );
  }
}
