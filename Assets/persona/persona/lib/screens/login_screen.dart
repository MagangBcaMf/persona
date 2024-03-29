import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persona/screens/home_screen.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/controller/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;

  final TextEditingController usercodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginRepository loginRepository = LoginRepository();

  String usercodeError = '';
  String passwordError = '';

  void login() async {
    String usercode = usercodeController.text;
    String password = passwordController.text;

    setState(() {
      usercodeError = '';
      passwordError = '';
    });

    if (usercode.isEmpty) {
      setState(() {
        usercodeError = 'Usercode harus diisi!';
      });
      return;
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Password harus diisi!';
      });
      return;
    }

    bool success = await loginRepository.login(usercode, password);

    
    if (success) {
      // print('Login success');
      // print(id_user);
      // await fetchDataFromRepository();

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else {
      print('Login failed');
    }
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;

  return WillPopScope(
    child: Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "assets/bglogin.png",
              width: screenWidth,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenWidth*0.35),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 80),
                        Image.asset("assets/logologin.png"),
                        SizedBox(height: 5),
                        Text('personA',
                            style: GoogleFonts.montserrat(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: 40),
                        TextFormField(
                          controller: usercodeController,
                          decoration: InputDecoration(
                            errorText:
                                usercodeError.isNotEmpty ? usercodeError : null,
                            labelText: 'Usercode',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        TextFormField(
                          controller: passwordController,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            errorText:
                                passwordError.isNotEmpty ? passwordError : null,
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          child: Text('Sign In'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff3D67FF),
                            minimumSize: Size(250, 50),
                            textStyle: GoogleFonts.istokWeb(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/change_password');
                            },
                            child: const Text('Lupa Sandi?'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ), 
    onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
  );
}


}
