import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  const InfoCard(
      {required this.title,
      required this.value,
      required this.icon,
      required this.sign,
      Key? key})
      : super(key: key);

  final String title;
  final String value;
  final IconData icon;
  final String sign;

  @override
  Widget build(BuildContext context) {
    final _devSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _devSize.width * .0575,
          width: _devSize.width * .0575,
          child: FittedBox(
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: _devSize.aspectRatio * 8,
        ),
        Text(
          '$value $sign',
          style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: _devSize.width * .03),
        ),
        SizedBox(
          height: _devSize.aspectRatio * 8,
        ),
        Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.white70,
            fontSize: _devSize.width * .03,
          ),
        ),
      ],
    );
  }
}
