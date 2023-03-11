import 'package:base_state/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedInformation extends StatefulWidget {
  const SavedInformation({Key? key}) : super(key: key);

  @override
  _SavedInformationState createState() => _SavedInformationState();
}

class _SavedInformationState extends State<SavedInformation> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String>? information;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SAVED_INFORMATION),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: FutureBuilder<String>(
          future: information,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text(ERROR_DATA_LOAD),
              );
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            String userNameAge = snapshot.data!;
            return Card(
              child: Center(
                child: Text(userNameAge),
              ),
            );
          },
        ),
      ),
    );
  }

  getInformation() {
    print("Bắt đầu lấy dữ liệu từ SharedPreference Database");
    information = _prefs.then((SharedPreferences? pref) {
      return (pref!.getString("information")) ??
          "Thông tin chưa được lưu vào bộ nhớ";
    });
  }
}
