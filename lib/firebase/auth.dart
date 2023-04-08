import 'package:app_jam_f9/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference get _users => _firestore.collection("users");
  Future<UserCredential?> signInWithCredential(String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Wrong password provided for that user.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
          ),
        );
      }

      return null;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('An error occurred. Please try again later.')));
      return null;
    }
  }

  // get current users name from firestore.

  Future<String> getCurrentUsersName() async {
    final currentUser = _auth.currentUser;
    final uid = currentUser!.uid;
    final user = await _users.doc(uid).get().then((value) => UserModel.fromMap(value.data() as Map<String, dynamic>));
    return user.name;
  }
  Future<String> getCurrentUsersMail() async {
    final currentUser = _auth.currentUser;
    final uid = currentUser!.uid;
    final user = await _users.doc(uid).get().then((value) => UserModel.fromMap(value.data() as Map<String, dynamic>));
    return user.email;
  }

  Future<UserModel?> getUserData(String uid) {
    return _users.doc(uid).get().then((value) => UserModel.fromMap(value.data() as Map<String, dynamic>));
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential?> createUser(String name, String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      UserModel userModel;
      if (credential.additionalUserInfo?.isNewUser ?? false) {
        userModel = UserModel(
          name: name,
          uid: credential.user!.uid,
          email: credential.user!.email!,
        );
        await _users.doc(userModel.uid).set(userModel.toMap());
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      } else {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message.toString()),
          ),
        );
      }

      return null;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      return null;
    }
  }
}
