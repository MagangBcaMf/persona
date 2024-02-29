import 'package:flutter/material.dart';
// import 'package:persona/widgets/bottom_navbar.dart';
import 'package:custom_accordion/custom_accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class KamusKeuanganScreen extends StatefulWidget {
  const KamusKeuanganScreen({Key? key}) : super(key: key);

  @override
  _KamusKeuanganScreenState createState() => _KamusKeuanganScreenState();
}

class _KamusKeuanganScreenState extends State<KamusKeuanganScreen> {
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
              Navigator.pushNamed(context, '/keuangan');
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

    Widget KamusDropdown() {
      return Container(
        width: screenWidth * 1,
        margin: EdgeInsets.only(top: 90, left: 25, right: 25),
        child: Column(
          children: [
            CustomAccordion(
              title: 'PPh',
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
              widgetItems: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PPh atau Pajak Penghasilan adalah pajak yang dikenakan kepada orang pribadi atau badan atas penghasilan yang diterima atau diperoleh dalam suatu tahun pajak.',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            CustomAccordion(
              title: 'PPN',
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
              widgetItems: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PPh atau Pajak Penghasilan adalah pajak yang dikenakan kepada orang pribadi atau badan atas penghasilan yang diterima atau diperoleh dalam suatu tahun pajak.',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            CustomAccordion(
              title: 'Bukti Transaksi',
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
              widgetItems: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PPh atau Pajak Penghasilan adalah pajak yang dikenakan kepada orang pribadi atau badan atas penghasilan yang diterima atau diperoleh dalam suatu tahun pajak.',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            CustomAccordion(
              title: 'COA',
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
              widgetItems: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PPh atau Pajak Penghasilan adalah pajak yang dikenakan kepada orang pribadi atau badan atas penghasilan yang diterima atau diperoleh dalam suatu tahun pajak.',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            CustomAccordion(
              title: 'GP',
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
              widgetItems: const Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'PPh atau Pajak Penghasilan adalah pajak yang dikenakan kepada orang pribadi atau badan atas penghasilan yang diterima atau diperoleh dalam suatu tahun pajak.',
                    style: TextStyle(),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 60)
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

    // Widget BottomNavBar() {
    //   return BottomNavigationBar(
    //     items: const <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.home, color: Color(0xff7da0ca)),
    //         label: 'Home',
    //         // backgroundColor: Colors.red,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.bell_fill, color: Color(0xff7da0ca)),
    //         label: 'Reminder',
    //         // backgroundColor: Colors.green,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(CupertinoIcons.book_solid, color: Color(0xff7da0ca)),
    //         label: 'Learning',
    //         // backgroundColor: Colors.purple,
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.person_rounded, color: Color(0xff7da0ca)),
    //         label: 'Profile',
    //         // backgroundColor: Colors.pink,
    //       ),
    //     ],
    //     currentIndex: _selectedIndex,
    //     selectedItemColor: Color(0xff7798C1),
    //     onTap: _onItemTapped,
    //   );
    // }

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
              child: KamusDropdown(),
            ),
            TopBar(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
