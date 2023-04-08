import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/screens/feed.dart';
import 'package:app_jam_f9/screens/new_post.dart';
import 'package:app_jam_f9/screens/post.dart';
import 'package:app_jam_f9/screens/user_profile.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'about_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const appTitle = 'Hoşgeldin';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: "Paylaşımlar"),
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
        backgroundColor: const Color(0XFF01579B),
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
                style: GoogleFonts.itim(color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: const CircleAvatar(child: Icon(Icons.account_circle_rounded)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfile()),
                );
              },
            ),
            ListTile(
              title: Text(
                'Yeni Paylaşılanlar',
                style: GoogleFonts.itim(color: const Color(0XFF01579B), fontSize: 20),
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
                'Yeni Paylaşım',
                style: GoogleFonts.itim(color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: const CircleAvatar(child: Icon(Icons.add)),
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddNewPost()),
                  );
                }
              },
            ),
            ListTile(
              title: Text(
                'Uygulama Hakkında',
                style: GoogleFonts.itim(color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: const CircleAvatar(child: Icon(Icons.info)),
              onTap: () {
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutApp()),
                  );
                }
              },
            ),
            ListTile(
                title: Text(
                  'Geliştiriciler',
                  style: GoogleFonts.itim(color: const Color(0XFF01579B), fontSize: 20),
                ),
                leading: const CircleAvatar(child: Icon(Icons.people_alt_rounded)),
                onTap: null),
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
