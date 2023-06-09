import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/firebase/firestore.dart';
import 'package:app_jam_f9/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  String dropdownValue = 'İstek';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final subjectController = TextEditingController();
  final textController = TextEditingController();
  final _auth = AuthRepository();
  final _firestore = FirestoreRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Paylaşım'),
        backgroundColor: const Color(0XFF01579B),
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
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFF01579B), width: 2.5),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFF01579B), width: 2),
                      borderRadius: BorderRadius.circular(30)),
                ),
                items: const [
                  DropdownMenuItem<String>(value: "İstek", child: Text("İstek")),
                  DropdownMenuItem<String>(value: "Öneri", child: Text("Öneri")),
                  DropdownMenuItem<String>(value: "Şikayet", child: Text("Şikayet"))
                ],
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                value: dropdownValue,
              ),
              const SizedBox(height: 30),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: subjectController,
                enableSuggestions: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Konu giriniz';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFF01579B), width: 2.5),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFF01579B), width: 2),
                      borderRadius: BorderRadius.circular(30)),
                  errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0XFF01579B), width: 2),
                      borderRadius: BorderRadius.circular(30)),
                  focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0XFF01579B), width: 2),
                  ),
                  labelText: 'Konu',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableSuggestions: true,
                controller: textController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Açıklama giriniz';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                maxLength: 244,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF01579B), width: 2.5),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF01579B), width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0XFF01579B), width: 2),
                        borderRadius: BorderRadius.circular(30)),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFF01579B), width: 2),
                    ),
                    hintText: "Açıklama"),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                child: Container(
                  margin: const EdgeInsets.only(right: 100, left: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF01579B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      final user = await _auth.getUserData(_auth.getCurrentUser()!.uid);
                      if (_formKey.currentState!.validate()) {
                        PostModel post = PostModel(
                          subject: subjectController.text,
                          text: textController.text,
                          category: dropdownValue,
                          postedById: user!.uid,
                          postedByName: user.name,
                          createdAt: DateTime.now(),
                          id: const Uuid().v1(),
                          likes: 0,
                          likedBy: [],
                        );
                        if (context.mounted) {
                          await _firestore.addPost(post, context);
                        }
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Paylaş',
                      style: GoogleFonts.sora(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card();
  }
}
