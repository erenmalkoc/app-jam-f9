import 'package:app_jam_f9/models/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference get _posts => _firestore.collection("posts");

  Future<void> addPost(PostModel post, BuildContext context) async {
    try {
      await _posts.doc(post.id).set(post.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> deletePost(PostModel post) async {
    await _posts.doc(post.id).delete();
  }

  Stream<List<PostModel>> getMostLikedPosts() {
    return _posts.orderBy('likes', descending: true).limit(100).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Stream<List<PostModel>> getMostRecentPosts() {
    return _posts.orderBy('createdAt', descending: true).limit(100).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  Stream<List<PostModel>> getPostsByUser(String uid) {
    return _posts.where('postedById', isEqualTo: uid).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => PostModel.fromMap(doc.data() as Map<String, dynamic>)).toList();
    });
  }

  void like(PostModel post, String userId, BuildContext context) async {
    try {
      await _posts.doc(post.id).update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([userId]),
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void unlike(PostModel post, String userId, BuildContext context) {
    try {
      _posts.doc(post.id).update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([userId]),
      });
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
