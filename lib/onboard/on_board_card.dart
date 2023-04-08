import 'package:app_jam_f9/models/onboard_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardCard extends StatelessWidget {
  const OnBoardCard({Key? key, required this.model}) : super(key: key);
  final OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          model.title,
          style: GoogleFonts.sora(color: const Color(0XFF01579B), fontSize: 40),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(model.description,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.sora(color: const Color(0XFF01579B), fontSize: 20)),
        SizedBox(
          height: 20,
        ),
        Image.asset(model.imageWithPath),
      ],
    );
  }
}
