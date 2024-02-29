import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

class ProdukKeuanganScreen extends StatefulWidget {
  const ProdukKeuanganScreen({Key? key}) : super(key: key);

  @override
  _ProdukKeuanganScreenState createState() => _ProdukKeuanganScreenState();
}

class _ProdukKeuanganScreenState extends State<ProdukKeuanganScreen> {
  @override
  Widget build(BuildContext context) {
    Widget TopBar() {
      return AppBar(
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
      );
    }

    Widget showModal() {
      return ElevatedButton(
        onPressed: () {
          showModalBottomSheet(
            elevation: 10,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                padding: EdgeInsets.all(25),
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/detailProdukKeuangan.png',
                    ),
                    SizedBox(height: 20),
                    Text(
                      'KPM adalah produk pembiayaan sepeda motor dari BCA Multi Finance yang diperuntukkan bagi masyarakat umum, perusahaan, maupun kolektif yang membutuhkan sepeda motor baru. KPM hadir dengan berbagai tenor dan DP yang sesuai dengan kemampuan Anda. KPM memberikan kemudahan bertransaksi dengan bekerjasama dengan Indomaret, Alfamart group, Kantor Pos dan BCA untuk pembayaran angsuran.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Text('Selengkapnya'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff7da0ca)),
        ),
      );
    }

    Widget produkCard(String imageAsset, String title, String description) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color(0xffF0EFEF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0.4,
              blurRadius: 1,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageAsset,
              width: 100,
              height: 100,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11),
                  ),
                  SizedBox(height: 10),
                  showModal(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget ProdukMenu() {
      return Container(
        padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
        child: Column(
          children: [
            produkCard(
              'assets/kpm.png',
              'Kredit Pemilikan Motor',
              'Produk pembiayaan masyarakat yang membutuhkan motor baru',
            ),
            produkCard(
              'assets/ksm.png',
              'Kredit Sepeda Motor',
              'Produk pembiayaan motor baru khusus nasabah BCA',
            ),
            produkCard(
              'assets/kmb.png',
              'Kredit Motor Bekas',
              'Produk pembiayaan bekas bagi peminat motor bekas',
            ),
            produkCard(
              'assets/kms.png',
              'Kredit Mobil Seken',
              'Produk pembiayaan mobil seken bagi masyarakat umum',
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bghome.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: ProdukMenu(),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: TopBar(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
