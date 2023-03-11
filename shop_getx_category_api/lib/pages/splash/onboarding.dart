import 'package:flutter/material.dart';
import 'package:flutter_overboard/flutter_overboard.dart';
import 'package:shop_getx_category_api/pages/login_signup/login.dart';

//Todo: OnBoardingScreen
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        finishCallback: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
      ),
    );
  }

  final pages = [
    PageModel(
        color: Colors.black,
        imageAssetPath: 'assets/02.png',
        title: 'Screen 1',
        body: 'Share your ideas with the team',
        doAnimateImage: true),
    PageModel(
        color: Colors.blue,
        imageAssetPath: 'assets/02.png',
        title: 'Screen 2',
        body: 'See the increase in productivity & output',
        doAnimateImage: true),
    PageModel(
        color: Colors.green,
        imageAssetPath: 'assets/02.png',
        title: 'Screen 3',
        body: 'Connect with the people from different places',
        doAnimateImage: true),
  ];
}
