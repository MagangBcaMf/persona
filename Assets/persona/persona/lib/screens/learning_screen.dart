import 'package:flutter/material.dart';
// import 'package:persona/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Widget MenuLearning() {
      return Center(
        child: Container(
          width: screenWidth * 1,
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Container(
                      height: screenWidth * 0.35,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                        color: Color(0xffF0EFEF),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: screenWidth * 0.001,
                            blurRadius: screenWidth * 0.005,
                            offset: Offset(0, screenWidth * 0.004),
                          )
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keuangan');
                        },
                        // splashColor: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/keuangan.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2),
                            const Text(
                              'Keuangan',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: screenWidth * 0.35,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                          color: Color(0xffF0EFEF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: screenWidth * 0.001,
                              blurRadius: screenWidth * 0.005,
                              offset: Offset(0, screenWidth * 0.004),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keuangan');
                        },
                        // splashColor: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/operasional.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2),
                            const Text(
                              'Operasional',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: screenWidth * 0.35,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                          color: Color(0xffF0EFEF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: screenWidth * 0.001,
                              blurRadius: screenWidth * 0.005,
                              offset: Offset(0, screenWidth * 0.004),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keuangan');
                        },
                        // splashColor: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/penagihan.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2),
                            const Text(
                              'Penagihan',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: screenWidth * 0.35,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                          color: Color(0xffF0EFEF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: screenWidth * 0.001,
                              blurRadius: screenWidth * 0.005,
                              offset: Offset(0, screenWidth * 0.004),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keuangan');
                        },
                        // splashColor: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/resiko.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2),
                            const Text(
                              'Risiko & Kepatuhan',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: screenWidth * 0.35,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                          color: Color(0xffF0EFEF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: screenWidth * 0.001,
                              blurRadius: screenWidth * 0.005,
                              offset: Offset(0, screenWidth * 0.004),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keuangan');
                        },
                        // splashColor: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/penjualan.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2),
                            const Text(
                              'Penjualan',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: screenWidth * 0.35,
                      width: screenWidth * 0.35,
                      decoration: BoxDecoration(
                          color: Color(0xffF0EFEF),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: screenWidth * 0.001,
                              blurRadius: screenWidth * 0.005,
                              offset: Offset(0, screenWidth * 0.004),
                            )
                          ]),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/keuangan');
                        },
                        // splashColor: Colors.redAccent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/itbispro.png',
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2),
                            const Text(
                              'IT & Bispro',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Widget BottomNavBar() {
    //   return Align(
    //     alignment: Alignment.bottomCenter,
    //     child: Container(
    //       padding: EdgeInsets.only(
    //         top: 14,
    //         left: 37,
    //         right: 37,
    //       ),
    //       color: Colors.white,
    //       height: 60,
    //       width: MediaQuery.of(context).size.width,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.pushNamed(context, '/home');
    //             },
    //             child: bottomNavbar(
    //               imgUrl: 'assets/home.png',
    //               title: 'Home',
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.pushNamed(context, '/reminder');
    //             },
    //             child: bottomNavbar(
    //               imgUrl: 'assets/reminder.png',
    //               title: 'Reminder',
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.pushNamed(context, '/learning');
    //             },
    //             child: bottomNavbar(
    //               imgUrl: 'assets/learning.png',
    //               title: 'Learning',
    //             ),
    //           ),
    //           GestureDetector(
    //             onTap: () {
    //               Navigator.pushNamed(context, '/profile');
    //             },
    //             child: bottomNavbar(
    //               imgUrl: 'assets/profile.png',
    //               title: 'Profile',
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

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
              label: 'Learning', icon: CupertinoIcons.book_solid),
          CustomBottomBarItems(
            label: 'Profile',
            icon: Icons.person_rounded,
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/bghome.png'),
                fit: BoxFit.cover,
              )),
            ),
            SingleChildScrollView(
              child: MenuLearning(),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
