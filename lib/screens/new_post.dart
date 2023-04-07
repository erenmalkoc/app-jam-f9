import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewPost extends StatefulWidget {
  const AddNewPost({Key? key}) : super(key: key);

  @override
  State<AddNewPost> createState() => _AddNewPostState();
}

class _AddNewPostState extends State<AddNewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('Yeni Paylasim'),
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
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(10),

        child: Form(
          child: Center(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    const SizedBox(height: 30),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.drive_file_rename_outline_sharp),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color :Color(0XFF01579B),width:2.5),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0XFF01579B),width: 2),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0XFF01579B),width: 2),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF01579B),width: 2),

                        ),
                        labelText: 'Baslik',
                      ),

                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.info),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color :Color(0XFF01579B),width:2.5),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0XFF01579B),width: 2),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0XFF01579B),width: 2),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0XFF01579B),width: 2),

                        ),
                        labelText: 'Konu Detayi'

                      ),


                    ),

                    const SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.only(right: 100,left: 100),
                        child: Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0XFF01579B),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: null,
                            child: Text(
                              'Paylas',
                              style: GoogleFonts.amaranth(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),

        ),
      ),
    );
  }
}
