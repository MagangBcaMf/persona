import 'package:flutter/material.dart';
// import 'package:persona/widgets/bottom_navbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LoginRepository loginRepository = LoginRepository();

  void logout() async {
    await loginRepository.logout();
    print('Logout success');
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Widget BodyProfileScreen() {
      return ListView(
        children: [
          SizedBox(height: screenWidth * 0.08),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.08),
                child: Container(
                  height: screenWidth * 0.4,
                  width: screenWidth * 1,
                  decoration: BoxDecoration(
                    color: Color(0xffF0EFEF),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0.6,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: screenWidth * 0.1),
                      ProfilePicture(
                        name: "${LoginRepository.username}",
                        radius: 43,
                        fontsize: 28,
                        random: true,
                      ),
                      SizedBox(width: 17),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 38),
                          Text(
                            "${LoginRepository.username}",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Manager',
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            "${LoginRepository.nik}",
                            style: GoogleFonts.montserrat(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.01),
                child: Container(
                  height: screenWidth * 0.37,
                  width: screenWidth * 0.85,
                  decoration: BoxDecoration(
                    color: Color(0xffF0EFEF),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0.6,
                        blurRadius: 1,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/change_password');
                        },
                        style: ElevatedButton.styleFrom(
                          // // primary: Colors.red,
                          backgroundColor: Color(0xffF0EFEF),
                          foregroundColor: Color(0xffF0EFEF),
                          elevation: 0,
                          minimumSize: Size(screenWidth * 0.85, 60),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Image.asset(
                              "assets/Key.png",
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Ubah Sandi',
                              style: GoogleFonts.montserrat(
                                fontSize: 21,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SizedBox(height: 10),
                      Divider(color: Colors.black),
                      // SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          logout();
                        },
                        style: ElevatedButton.styleFrom(
                          // // primary: Colors.red,
                          backgroundColor: Color(0xffF0EFEF),
                          foregroundColor: Color(0xffF0EFEF),
                          elevation: 0,
                          minimumSize: Size(screenWidth * 0.85, 60),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 15),
                            Image.asset(
                              "assets/Logout.png",
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Keluar',
                              style: GoogleFonts.montserrat(
                                fontSize: 21,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    int _selectedIndex = 3;
    void _onItemTapped(int index) {
      if (index != _selectedIndex) {
        setState(() {
          _selectedIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/reminder');
            break;
          case 2:
            Navigator.pushNamed(context, '/learning');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      }
    }

    Widget BottomNavBar() {
      return CustomLineIndicatorBottomNavbar(
        selectedColor: Color(0xff7da0ca),
        unSelectedColor: Colors.black54,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Top,
        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Home',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Reminder',
            icon: CupertinoIcons.bell_fill,
          ),
          CustomBottomBarItems(
            label: 'Learning',
            icon: CupertinoIcons.book_solid,
          ),
          CustomBottomBarItems(
            label: 'Profile',
            icon: Icons.person_rounded,
          ),
        ],
      );
    }

    Widget VersionInfo() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            Text(
              'personA',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Version 1.0',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bghome.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            BodyProfileScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VersionInfo(),
          BottomNavBar(),
        ],
      ),
    );
  }
}
