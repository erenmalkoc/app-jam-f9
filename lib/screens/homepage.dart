import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/firebase/firestore.dart';
import 'package:app_jam_f9/models/user_model.dart';
import 'package:app_jam_f9/screens/feed.dart';
import 'package:app_jam_f9/screens/new_post.dart';
import 'package:app_jam_f9/screens/post.dart';
import 'package:app_jam_f9/screens/user_profile.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const appTitle = 'Hoşgeldin';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: "hi "),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = AuthRepository();

  String name = "";

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () async {
                await _auth.signOut();
              })
        ],
        shape: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0XFF01579B), width: 2.5),
            borderRadius: BorderRadius.circular(10)),
      ),
      body: const Center(
        child: Feed(),
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
                'Profil',
                style: GoogleFonts.amaranth(color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: CircleAvatar(child: const Icon(Icons.account_circle_rounded)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfile()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Yeni Paylasilanlar',
                style: GoogleFonts.amaranth(color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: const CircleAvatar(
                child: Icon(Icons.table_rows),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Post()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Yeni Paylasim',
                style: GoogleFonts.amaranth(color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: CircleAvatar(child: const Icon(Icons.add)),
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddNewPost()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
