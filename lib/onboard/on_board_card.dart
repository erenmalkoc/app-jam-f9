import 'package:app_jam_f9/models/onboard_model.dart';
import 'package:app_jam_f9/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardCard extends StatelessWidget {
  const OnBoardCard({Key? key, required this.model}) : super(key: key);
  final OnBoardModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          model.title,
          style: GoogleFonts.sora(color: const Color(0XFF01579B), fontSize: 30),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(model.description,
            textAlign: TextAlign.center, style: GoogleFonts.sora(color: const Color(0XFF01579B), fontSize: 20)),
        const SizedBox(
          height: 20,
        ),
        Image.asset(model.imageWithPath,
        width: 300,
          height: 300,
        ),
        model.title.length == 56
            ? Container(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color(0XFF01579B),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.all(16)),
                      child: Text("Kullanmaya Başla", style: GoogleFonts.sora(color: Colors.white, fontSize: 15)),
                    ),
                  ],
                ),
              )
            : const SizedBox(
                height: 0,
              ),
      ],
    );
  }
}
