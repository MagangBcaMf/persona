import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:persona/screens/home_screen.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Widget AppBar() {
    //   return SliverAppBar(
    //     pinned: true,
    //     leading: IconButton(
    //       onPressed: () {
    //         Navigator.pushNamed(context, '/home');
    //       },
    //       icon: Icon(CupertinoIcons.arrow_left),
    //     ),
    //     backgroundColor: Colors.transparent,
    //     title: Transform.translate(
    //       offset: Offset(-16, 0),
    //       child: Text('PersonA'),
    //     ),
    //     titleTextStyle: const TextStyle(
    //       fontSize: 22,
    //       fontWeight: FontWeight.bold,
    //     ),
    //     leadingWidth: 50,
    //     flexibleSpace: FlexibleSpaceBar(
    //       background: Container(
    //         decoration: const BoxDecoration(
    //           gradient: LinearGradient(
    //             colors: [
    //               Color(0xff7DA0CA),
    //               Color(0xff93B1D3)
    //             ], // Ganti warna sesuai kebutuhan
    //             begin: Alignment.topCenter,
    //             end: Alignment.bottomCenter,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    Widget CustomAppBar() {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 0, bottom: 665),
        child: AppBar(
          leading: IconButton(
            onPressed: () {
              // Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          // backgroundColor: Colors.transparent,
          backgroundColor: Color(0xff7798C1),
          // elevation: 0,
          title: const Text(
            'PersonA',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget Details() {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 55),
            Image(image: (AssetImage("assets/info4.jpg"))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "BCA Multifinance menjadi The Best Performance Multi-Finance Company "
                "dan Predikat “Sangat Bagus”. Era endemi, Industri Keuangan Non-Bank kembali "
                "bangkit menciptakan peluang pertumbuhan keuangan setelah lebih dari dua "
                "tahun melalui masa sulit. Ditopang dengan kembalinya aktivitas masyarakat "
                "untuk bekerja, berdampak pada daya beli yang perlahan semakinmembaik."
                "BCA Multifinance menjadi The Best Performance Multi-Finance Company "
                "dan Predikat “Sangat Bagus”. Era endemi, Industri Keuangan Non-Bank kembali "
                "bangkit menciptakan peluang pertumbuhan keuangan setelah lebih dari dua "
                "tahun melalui masa sulit. Ditopang dengan kembalinya aktivitas masyarakat "
                "untuk bekerja, berdampak pada daya beli yang perlahan semakinmembaik.",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/bghome.png'),
                  fit: BoxFit.cover,
                )),
              ),
              Details(),
              CustomAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
