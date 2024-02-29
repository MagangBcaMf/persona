import 'package:flutter/material.dart';
// import 'package:persona/widgets/bottom_navbar.dart';
import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class LearningKeuanganScreen extends StatefulWidget {
  const LearningKeuanganScreen({Key? key}) : super(key: key);

  @override
  _LearningKeuanganScreenState createState() => _LearningKeuanganScreenState();
}

class _LearningKeuanganScreenState extends State<LearningKeuanganScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Widget TopBar() {
      return Container(
        width: screenWidth * 1,
        padding: EdgeInsets.only(top: 0, bottom: screenHeight * 0.8),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/learning');
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'personA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget KnowledgeMenu() {
      return Container(
        width: screenWidth,
        margin: EdgeInsets.only(top: 90, left: 25, right: 25),
        child: Column(
          children: [
            CustomAccordion(
              title: 'Knowledge',
              headerBackgroundColor: Color(0xffF0EFEF),
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              toggleIconOpen: Icons.keyboard_arrow_down_sharp,
              toggleIconClose: Icons.keyboard_arrow_up_sharp,
              headerIconColor: Colors.grey,
              accordionElevation: 2,
              backgroundColor: Color(0xffF0EFEF),
              widgetItems: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/produkKeuangan');
                    },
                    child: Text(
                      'Sosialisasi Produk',
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff7da0ca))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/kamusKeuangan');
                    },
                    child: Text(
                      'Kamus Perusahaan',
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff7da0ca))),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            CustomAccordion(
              title: 'Instruction',
              headerBackgroundColor: Color(0xffF0EFEF),
              titleStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              toggleIconOpen: Icons.keyboard_arrow_down_sharp,
              toggleIconClose: Icons.keyboard_arrow_up_sharp,
              headerIconColor: Colors.grey,
              accordionElevation: 2,
              backgroundColor: Color(0xffF0EFEF),
              widgetItems: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/instruksiKeuangan');
                    },
                    child: Text(
                      'Pelatihan',
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff7da0ca))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/instruksiKeuangan');
                    },
                    child: Text(
                      'Instruksi Kerja',
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xff7da0ca))),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    int _selectedIndex = 2;
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
              child: KnowledgeMenu(),
            ),
            TopBar(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
