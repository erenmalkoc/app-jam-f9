import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/firebase/firestore.dart';
import 'package:app_jam_f9/models/post_model.dart';
import 'package:app_jam_f9/models/user_model.dart';
import 'package:app_jam_f9/screens/feed.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyFeed extends StatefulWidget {
  const MyFeed({super.key});

  @override
  State<MyFeed> createState() => _FeedState();
}

class _FeedState extends State<MyFeed> {
  final _firestore = FirestoreRepository();
  final _auth = AuthRepository();
  final postController = TextEditingController();
  String userId = "";
  String name = "";
  String email = "";
  Future<void> getUid(String uid) async {
    UserModel? user = await _auth.getUserData(uid);
    if (user != null) {
      setState(() {
        userId = user.uid;
        name = user.name;
        email = user.email;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUid(_auth.getCurrentUser()!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
        stream: _firestore.getPostsByUser(userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    color: const Color(0XFF90CAF9),
                    elevation: 10,
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Color(0XFF90CAF9))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    const Icon(Icons.account_circle_rounded),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      post.postedByName,
                                      style: const TextStyle(color: Color(0XFF004D40)),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                post.category,
                                style: TextStyle(color: colorChange(post.category)),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            post.subject,
                            style: GoogleFonts.sora(color: Colors.black, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            post.text,
                            style: GoogleFonts.sora(color: Colors.white, fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${post.likes.toInt()} beğeni"),
                              const SizedBox(
                                width: 110,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      if (snapshot.data![index].likedBy.contains(_auth.getCurrentUser()!.uid)) {
                                        _firestore.unlike(post, _auth.getCurrentUser()!.uid, context);
                                      } else {
                                        _firestore.like(post, _auth.getCurrentUser()!.uid, context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0XFF01579B),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    icon: post.likedBy.contains(_auth.getCurrentUser()!.uid)
                                        ? const Icon(Icons.thumb_up)
                                        : const Icon(
                                            Icons.thumb_up_outlined,
                                            color: Color(0XFF01579B),
                                          ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await _firestore.deletePost(post);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
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
        });
  }
}
