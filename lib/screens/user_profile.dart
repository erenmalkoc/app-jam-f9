import 'package:app_jam_f9/screens/my_feed.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase/auth.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = AuthRepository();

  String name = "";
  String email = "";

  void setMail() async {
    final currentMail = _auth.getCurrentUser()!.email;
    setState(() {
      email = currentMail!;
    });
  }

  void setName() async {
    final currentName = await _auth.getUserData(_auth.getCurrentUser()!.uid);
    setState(() {
      name = currentName!.name;
    });
  }

  @override
  void initState() {
    super.initState();
    setName();
    setMail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: const Color(0XFF01579B),
        actions: const <Widget>[
          IconButton(
              icon: Icon(
                Icons.login,
                color: Colors.white,
              ),
              onPressed: null)
        ],
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF01579B), width: 2.5),
            borderRadius: BorderRadius.circular(10)),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 100, width: 100, child: Image.asset('assets/ic_profile.png')),
              Text(
                name,
                style: GoogleFonts.itim(color: Colors.blueGrey, fontSize: 30),
              ),
              Text(
                email,
                style: GoogleFonts.robotoMono(color: Colors.blueGrey, fontSize: 20),
              ),
              Text(
                '------------------------',
                style: GoogleFonts.robotoMono(color: Colors.blueGrey, fontSize: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Benim Paylaştıklarım:',
                    style: GoogleFonts.itim(color: Colors.blueGrey, fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const MyFeed(),
            ],
          )),
    );
  }
}
