
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});


  static const appTitle = 'Hoşgeldin';


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title:"hi " ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),
        actions: const <Widget>[
           IconButton(
            icon:  Icon(
              Icons.login,
              color: Colors.white,
            ),
            onPressed: null
          )
        ],
        shape:  OutlineInputBorder(
            borderSide: const BorderSide(color :Color(0XFF01579B),width:2.5),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      body: const Center(
        child: Text('My Page!'),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Username',
                style: GoogleFonts.amaranth(
                    color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              title: Text(
                'Profil',
                style: GoogleFonts.amaranth(
                    color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: CircleAvatar(child: const Icon(Icons.account_circle_rounded)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Paylasımlar',
                style: GoogleFonts.amaranth(
                    color: const Color(0XFF01579B), fontSize: 20),
              ),
              leading: const CircleAvatar(child: Icon(Icons.table_rows),),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}