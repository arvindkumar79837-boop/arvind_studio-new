import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/splash/splash_screen.dart';

void main() {
  runApp(const ArvindStudio());
}

class ArvindStudio extends StatelessWidget {
  const ArvindStudio({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'ARVIND STUDIO',

      theme: ThemeData.dark().copyWith(

        scaffoldBackgroundColor: const Color(0xff1e1e1e),

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff252526),
        ),

      ),

      home: const SplashScreen(),
    );
  }
}
