import 'package:flutter/material.dart';
import 'package:shop_getx_category_api/main.dart';
import 'package:shop_getx_category_api/pages/splash/onboarding.dart';

import '../../state.dart';

//Todo: SplashScreen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => OnBoardingScreen()),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://yt3.ggpht.com/ytc/AKedOLRbFDdhN1oj-Bp5PJC4_xNzScgeN7EHa7weg_zL=s900-c-k-c0x00ffffff-no-rj"),
                ),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 64),
            const Text(
              "NShop",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
