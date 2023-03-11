import 'package:base_state/resources/common_widget.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  final String userName;
  final String age;
  const InformationScreen({Key? key, required this.userName, required this.age})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: informationWidget(userNameContent: userName, ageContent: age),
        ),
      ),
    );
  }
}
