import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/firebase/firestore.dart';
import 'package:app_jam_f9/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class NewFeed extends StatefulWidget {
  const NewFeed({super.key});

  @override
  State<NewFeed> createState() => _FeedState();
}

class _FeedState extends State<NewFeed> {
  final _firestore = FirestoreRepository();
  final _auth = AuthRepository();
  final postController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),
            StreamBuilder<List<PostModel>>(
                stream: _firestore.getMostRecentPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data![index];
                          return Card(

                            color: Color(0XFF90CAF9),
                            elevation: 10,
                            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Color(0XFF90CAF9))),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.account_circle_rounded),
                                      Text(post.postedByName,
                                        style: TextStyle(color: Color(0XFF004D40)),
                                      ),

                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    post.subject,
                                    style:
                                    GoogleFonts.sora(color: Colors.white, fontSize: 10),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(post.text,
                                    style:
                                    GoogleFonts.sora(color: Colors.black, fontSize: 14),
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${post.likes.toInt()} beğeni"),
                                      const SizedBox(width: 110,),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (snapshot.data![index].likedBy.contains(_auth.getCurrentUser()!.uid)) {
                                            _firestore.unlike(post, _auth.getCurrentUser()!.uid, context);
                                          } else {
                                            _firestore.like(post, _auth.getCurrentUser()!.uid, context);
                                          }
                                        },
                                        child: const Text("Beğen"),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0XFF01579B),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(child: CircularProgressIndicator());
                })
          ],
        ),
      ),
    );
  }
}
