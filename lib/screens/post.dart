import 'package:app_jam_f9/screens/homepage.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase/auth.dart';

import 'new_feed.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  final _auth = AuthRepository();
  final postController = TextEditingController();

  String name = "";
  String email = "";

  void setMail() async {
    final currentMail = await _auth.getCurrentUsersMail();
    setState(() {
      email = currentMail;
    });
  }

  void setName() async {
    final currentName = await _auth.getCurrentUsersName();
    setState(() {
      name = currentName;
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
        backgroundColor: const Color(0XFF01579B),
        title: const Text('Yeni Paylaşılanlar'),
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
      body: const Center(
        child: NewFeed(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: Color(0XFF01579B),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.amaranth(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://upload.wikimedia.org/wikipedia/commons/a/ac/Default_pfp.jpg"),
                  ),
                ],
              ),
            ),
            ListTile(
                title: Text(
                  'Trend Paylaşımlar',
                  style: GoogleFonts.itim(color: const Color(0XFF01579B), fontSize: 20),
                ),
                leading: const CircleAvatar(child: Icon(Icons.swipe_up_sharp)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                }),
            const SizedBox(
              height: 50,
            ),
            ListTile(
                title: Center(
                  child: Text(
                    'sürüm 0.1',
                    style: GoogleFonts.robotoMono(color: const Color(0XFF01579B), fontSize: 15),
                  ),
                ),
                onTap: null),
          ],
        ),
      ),
    );
  }
}
