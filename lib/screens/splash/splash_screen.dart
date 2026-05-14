import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 3),
      () {

        Get.off(
          () => const HomeScreen(),
        );

      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            Container(

              width: 120,
              height: 120,

              decoration: BoxDecoration(

                color: Colors.greenAccent,

                borderRadius: BorderRadius.circular(25),

              ),

              child: const Icon(
                Icons.code,
                color: Colors.black,
                size: 70,
              ),
            ),

            const SizedBox(height: 30),

            const Text(

              "ARVIND STUDIO",

              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(

              "Mobile Developer IDE",

              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            const CircularProgressIndicator(
              color: Colors.greenAccent,
            ),

          ],
        ),
      ),
    );
  }
}
