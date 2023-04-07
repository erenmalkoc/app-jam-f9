import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Paylasimlar'),
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
      body: const Text('Hello'),
    );
  }
}
