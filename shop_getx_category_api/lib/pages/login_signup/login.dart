// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:shop_getx_category_api/color.dart';
import 'package:shop_getx_category_api/main.dart';
import 'package:shop_getx_category_api/pages/login_signup/signup.dart';

import '../home_cart/home.dart';

//Todo: LoginPage
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTop(),
            Form(
              key: _fromKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      child: TextFormField(
                        controller: username,
                        validator: (t) {
                          if (t!.isEmpty) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: "UserName",
                          labelText: "UserName",
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Card(
                      child: TextFormField(
                        controller: password,
                        validator: (t) {
                          if (t!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText: "Password",
                          labelText: "Password",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password ?",
                            style: TextStyle(color: kcPrimaryColor),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsetsDirectional.all(18),
                                backgroundColor: kcPrimaryColor,
                              ),
                              onPressed: () {
                                if (_fromKey.currentState!.validate()) {
                                  var result = authController.login(
                                      username.text, password.text);
                                  //*-->Kiem_tra_dieu_kien
                                  if (result) {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => HomeView()),
                                    );
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("Sucessfully logged in"),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Invalid login credentials"),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Invalid username or password"),
                                    ),
                                  );
                                }
                              },
                              child: const Text("LOGIN"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don not have account ?"),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: Text(
                              "create a new account",
                              style: TextStyle(color: kcPrimaryColor),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //*-->BuildTop()
  Column _buildTop() {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: Icon(
            Icons.person_outline,
            size: 40,
            color: Colors.grey[400],
          ),
          maxRadius: 40,
        ),
        const SizedBox(height: 16),
        const Text(
          "Welcome",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Signup to conitue",
          style: TextStyle(
            color: Colors.grey[400],
          ),
        )
      ],
    );
  }
}
