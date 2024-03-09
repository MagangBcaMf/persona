import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persona/repository/repository.dart';
import 'package:persona/screens/util.dart';
// import 'package:persona/widgets/bottom_navbar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:persona/widgets/home_event_image.dart';
// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';

import '../widgets/home_latest_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  int _selectedIndex = 0;
  @override
  void initState(){
    // TODO: implement initState
    // await fetchDataFromRepository();

    super.initState();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    void _showDialog(String title, List<String> contentList) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: contentList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('${index + 1}. ${contentList[index]}'),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    }

    Widget Welcome(BuildContext context, int notificationCount) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 15.0, 0.0, 0.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      'personA',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 230),
                  ],
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: Icon(Icons.email, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, '/notification');
                      },
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        top: 11,
                        right: 9,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 0.0, 10.0),
            child: Text(
              "Selamat datang, ${LoginRepository.username}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    }

    Widget EventSlider() {
      return Container(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 0,
        ),
        // height: 250, // Container size
        // color: Colors.grey,
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: ImageData.imageUrls.length,
              options: CarouselOptions(
                height: 180,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final imageUrl = ImageData.imageUrls[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/news_detail');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: screenWidth * 0.003,
                          blurRadius: screenWidth * 0.005,
                          offset: Offset(2, screenWidth * 0.006),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 10),
            AnimatedSmoothIndicator(
              activeIndex: currentIndex,
              count: ImageData.imageUrls.length,
              effect: const WormEffect(
                dotWidth: 8,
                dotHeight: 8,
              ),
            ),
          ],
        ),
      );
    }

    Widget Culture() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 20.0, 0.0, 10.0),
            child: Text(
              "Budaya Perusahaan",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff0366B5),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDialog("SERVE MORE PEOPLE", [
                          "Memberikan pelayanan terbaik bagi pelanggan dan calon pelanggan serta sesama karyawan Perusahaan",
                          "Memberikan solusi yang terbaik dan melebihi kepuasan bagi pelanggan dan calon pelanggan serta sesama karyawan Perusahaan"
                        ]);
                      },
                      child: Container(
                        height: 55.0,
                        width: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color(0xff0065B3),
                        ),
                        child: const Center(
                          child: Text(
                            "S",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDialog("MINDSET TO EXCELLENCE", [
                          "Senantiasa meningkatkan kualitas kerja guna memberikan hasil kerja yang memuaskan",
                          "Melakukan perencanaan kerja yang matang",
                          "Melakukan evaluasi dalam setiap pekerjaan",
                          "Melakukan perbaikan berkala dalam setiap pekerjaan",
                          "Memiliki mindset “the winner” yang selalu ingin mencapai lebih dari yang diminta Perusahaan"
                        ]);
                      },
                      child: Container(
                        height: 55.0,
                        width: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color(0xffED2124),
                        ),
                        child: const Center(
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDialog("ACT WITH INTEGRITY", [
                          "Jujur dalam berpikir dan bertindak",
                          "Bebas dari pengaruh dan keinginan memanipulasi",
                          "Disiplin dan bertanggungjawab dalam setiap pekerjaan",
                          "Mengambil keputusan dalam pekerjaan secara obyektif, bukan berdasarkan kepentingan atau pilihan pribadi",
                          "Bertindak sesuai ketentuan yang berlaku",
                          "Memiliki nilai dasar yang menolak dan memusuhi segala jenis Korupsi, Kolusi, Nepotisme (KKN) dan kegiatan-kegiatan yang"
                              " melanggar norma-norma dan ketentuan perundang-undangan yang berlaku"
                        ]);
                      },
                      child: Container(
                        height: 55.0,
                        width: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color(0xffFDB813),
                        ),
                        child: const Center(
                          child: Text(
                            "A",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDialog("RESPECT AND CARE", [
                          "Melandasi semangat kerja tinggi dengan rasa bangga dan rasa memiliki Perusahaan",
                          "Menciptakan kerjasama dan hubungan yang tulus untuk mencapai hasil terbaik bagi Perusahan",
                          "Memberikan kepedulian dan bantuan terbaik kepada sesama anggota tim",
                          "Menghargai perbedaan pendapat antar sesama anggota tim atau unit kerja lain",
                          "Menghormati harkat dan martabat sesama anggota tim atau unit kerja lain dengan menerapkan rasa hormat dalam komunikasi dan interaksi kerja"
                        ]);
                      },
                      child: Container(
                        height: 55.0,
                        width: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color(0xff00B0AD),
                        ),
                        child: const Center(
                          child: Text(
                            "R",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showDialog("TOUGH MENTALITY", [
                          "Ketangguhan yang cerdas untuk meraih hasil melampaui target",
                          "Keteguhan untuk selalu menjadi yang terbaik",
                          "Memiliki mental yang tidak mudah patah semangat dan selalu ingin mencapai yang lebih dibanding umumnya"
                        ]);
                      },
                      child: Container(
                        height: 55.0,
                        width: 55.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Color(0xff0065B3),
                        ),
                        child: const Center(
                          child: Text(
                            "T",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget Approval() {
      return Center(
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(18.0, 20.0, 18.0, 10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/approval');
          },
          child: Container(
            height: 60,
            width: screenWidth * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.transparent,
            ),
            child: Center(
              child: Container(
                width: screenWidth * 0.75,
                child: RichText(
                  text: const TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Ada ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "30 APPROVAL",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text:
                            " yang belum kamu setujui nih. Yuk segera diselesaikan ya.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget LatestEvent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(18.0, 20.0, 0.0, 0.0),
            child: Text(
              "Event Perusahaan",
              style: TextStyle(
                  color: Color(0xff0366B5),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 10.0),
            child: SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 120.0,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/news1.png"),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 120.0,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/news2.png"),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 120.0,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/news1.png"),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.amber,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    width: 120.0,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/news2.png"),
                          fit: BoxFit.contain),
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget LatestNews() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Berita Terkini",
                  style: TextStyle(
                    color: Color(0xff0366B5),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0366B5),
                    foregroundColor: Colors.white,
                    minimumSize: Size(50.0, 28.0),
                  ),
                  child: Text("See All"),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 10.0),
            child: Container(
              height: 330,
              child: Column(
                children: NewsData.NewsList.map((newsData) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: screenWidth * 0.33,
                          decoration: BoxDecoration(color: Colors.red),
                          child: Image.asset(
                            newsData.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            width: 0.67 * screenWidth,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                newsData.caption,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      );
    }

    int _selectedIndex = 0;
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
            label: 'Beranda',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Jadwal',
            icon: CupertinoIcons.bell_fill,
          ),
          CustomBottomBarItems(
              label: 'Pembelajaran', icon: CupertinoIcons.book_solid),
          CustomBottomBarItems(
            label: 'Profil',
            icon: Icons.person_rounded,
          ),
        ],
      );
    }

    Widget buildNotificationIcon(BuildContext context, int notificationCount) {
      return Positioned(
        top: 10.0,
        right: 10.0,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              icon: Icon(Icons.email, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/notification');
              },
            ),
            if (notificationCount > 0)
              Positioned(
                right: 9,
                top: 11,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bghome.png"), fit: BoxFit.fill),
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Welcome(context, 2),
                    Approval(),
                    EventSlider(),
                    Culture(),
                    LatestEvent(),
                    LatestNews(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
