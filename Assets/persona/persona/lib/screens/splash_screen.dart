import 'package:flutter/material.dart';
import 'package:persona/screens/login_screen.dart';
import 'package:persona/screens/onboarding_screen.dart';
// import 'package:persona/screens/home_screen.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checkFirstTimeUser();
    });
  }

  /*----testing intro----*/

  Future<void> resetSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void checkFirstTimeUser() async {
    // await resetSharedPreferences();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('firstTime') ?? true;

    if (isFirstTime) {
      await prefs.setBool('firstTime', false);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => OnBoardingScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => LoginScreen(),
      ));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/bgfull.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Text(
                  'p',
                  style: GoogleFonts.kavoon(
                    fontSize: 60,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'personA',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
