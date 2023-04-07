import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/firebase/firestore.dart';
import 'package:app_jam_f9/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                stream: _firestore.getMostLikedPosts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post.postedByName),
                                  Text(post.text),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${post.likes.toInt()} likes"),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (snapshot.data![index].likedBy.contains(_auth.getCurrentUser()!.uid)) {
                                            _firestore.unlike(post, _auth.getCurrentUser()!.uid, context);
                                          } else {
                                            _firestore.like(post, _auth.getCurrentUser()!.uid, context);
                                          }
                                        },
                                        child: const Text("Like"),
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
