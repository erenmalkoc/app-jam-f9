import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil'),
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
      body: const Text('Hello'),

    );
  }
}
