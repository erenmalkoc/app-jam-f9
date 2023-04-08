import 'package:app_jam_f9/firebase/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password = "";
  String email = "";
  String name = "";
  final _auth = AuthRepository();
  void emailChange(String? value) {
    setState(() {
      email = value ?? "";
    });
  }

  void passChange(String? value) {
    setState(() {
      password = value ?? "";
    });
  }

  void nameChange(String? value) {
    setState(() {
      name = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0XFF01579B),
        centerTitle: true,
        title: Text(
          'Kayıt Ol',
          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_register.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Devam etmek için kayıt ol',
                  style: GoogleFonts.sora(color: const Color(0XFF01579B), fontSize: 20),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.drive_file_rename_outline_sharp),
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
                    labelText: 'İsim',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş geçilemez';
                    }
                    return null;
                  },
                  onSaved: nameChange,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
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
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş geçilemez';
                    }
                    return null;
                  },
                  onSaved: emailChange,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enableSuggestions: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
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
                    labelText: 'Şifre',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bu alan boş geçilemez';
                    }
                    return null;
                  },
                  onSaved: passChange,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final res = await _auth.createUser(name, email, password, context);
                          if (context.mounted) {
                            if (res != null) {
                              Navigator.pop(context);
                            }
                          }
                        }
                      },
                      child: Text(
                        'Kayıt Ol',
                        style: GoogleFonts.sora(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
