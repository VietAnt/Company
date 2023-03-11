// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

Widget textInputWidget(
    {required String labelText,
    required String hintText,
    required controller}) {
  print("Hàm Input widget được chạy ");
  return Container(
      padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
      child: TextField(
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText),
        controller: controller,
      ));
}

Widget confirmationButton({required onPressed, required String lableButton}) {
  return ElevatedButton(onPressed: onPressed, child: Text(lableButton));
}

Widget informationWidget(
    {required String userNameContent, required String ageContent}) {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
    child: Card(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Text("Thông tin"),
            const SizedBox(
              height: 10,
            ),
            textWidget(labelText: "Họ và tên: ", content: userNameContent),
            const SizedBox(
              height: 10,
            ),
            textWidget(labelText: "Tuổi: ", content: ageContent),
          ],
        ),
      ),
    ),
  );
}

textWidget({required String labelText, required String content}) {
  return Container(
    child: Row(
      children: [
        Text(
          labelText,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(content)
      ],
    ),
  );
}
