import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              buildPage("Page 1", "assets/bgintro.png", "assets/intro1.png"),
              buildPage("Page 2", "assets/bgintro.png", "assets/intro2.png"),
              buildPage("Page 3", "assets/bgintro.png", "assets/intro3.png"),
              buildPage("Page 4", "assets/bgintro.png", "assets/intro4.png"),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 25),
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(3);
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0, right: 25),
              child: TextButton(
                onPressed: () {
                  if (_currentPage < 3) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  } else {
                    // Navigate to the next screen or perform any other action
                  }
                },
                child: Text(
                  _currentPage == 3 ? "Finish" : "Next",
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(String title, String imageAsset, String logoImage) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 40,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // const SizedBox(height: 70),
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                logoImage,
                width: 300,
                height: 200,
              ),
              const Positioned(
                top: 11,
                bottom: 110,
                child: Text(
                  'Selamat datang di PersonA',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 4; i++) {
      indicators.add(
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == i ? Colors.blue : Colors.grey,
          ),
        ),
      );
    }

    return indicators;
  }
}
