import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class budayaSmart extends StatelessWidget {
  final String? imgUrl;
  final String? title;

  const budayaSmart({this.imgUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1),
      child: Column(
        children: [
          Image.asset(
            imgUrl!,
            width: 20,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            title!,
            style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
