
import 'package:flutter/material.dart';



class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _UserProfileState();
}

class _UserProfileState extends State<AboutApp> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Uygulama Hakkında'),
        backgroundColor: Color(0XFF01579B),
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
      body:  Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ic_about_app.png"),
              fit: BoxFit.cover,
            ),
          ),

        ),
      ),

    );
  }
}
