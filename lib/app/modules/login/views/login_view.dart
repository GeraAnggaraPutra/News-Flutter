import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Container(
                height: 300,
                child: Lottie.network(
                  'https://assets2.lottiefiles.com/packages/lf20_jcikwtux.json',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controller.emailController,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 35,
                      color: Colors.black,
                    ),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Masukkan email',
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                  ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              child: TextField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: InputDecoration(
                     focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 35,
                      color: Colors.black,
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Masukkan Password',
                    hintStyle: TextStyle(
                      color: Colors.black
                    ),
                    fillColor: Colors.black,
                  ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextButton(
                onPressed: () {
                  controller.loginNow();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
