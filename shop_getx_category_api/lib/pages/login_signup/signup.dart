import 'package:flutter/material.dart';
import 'package:shop_getx_category_api/color.dart';
import 'package:shop_getx_category_api/main.dart';
import 'package:shop_getx_category_api/pages/login_signup/login.dart';

import '../home_cart/home.dart';

//Todo: SignupPage: Đăng_Ký_Tài_Khoản
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTop(),
            Form(
              key: _formKey,
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
                          hintText: "Username",
                          labelText: "Username",
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
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsetsDirectional.all(18),
                                  backgroundColor: kcPrimaryColor),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  authController.register(
                                      username.text, password.text);
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => HomeView(),
                                    ),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Sucessfully Registered")),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Invalid username or password"),
                                    ),
                                  );
                                }
                              },
                              child: const Text("CREATE ACCOUNT")),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: kcPrimaryColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //*-->_buildTop
  Column _buildTop() {
    return Column(
      children: [
        const Text(
          "Create Account",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "create a new account",
          style: TextStyle(color: Colors.grey[400]),
        )
      ],
    );
  }
}
