import 'package:app_jam_f9/firebase/auth.dart';
import 'package:app_jam_f9/screens/Register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String password = "";
  String email = "";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0XFF01579B),
        title: Text(
          'UpToSee',
          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg_login.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
              child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Giriş Yap',
                  style: GoogleFonts.sora(
                      color: const Color(0XFF01579B), fontSize: 20),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  cursorColor: const Color(0XFF01579B),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color :Color(0XFF01579B),width:2.5),
                  borderRadius: BorderRadius.circular(30)
              ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0XFF01579B),width: 2),
                borderRadius: BorderRadius.circular(30)
            ),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:Color(0XFF01579B),width: 2),
                borderRadius: BorderRadius.circular(30)
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0XFF01579B),width: 2),

            ),
            labelText: 'Email',
          ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir email giriniz';
                    }
                    return null;
                  },
                  onSaved: emailChange,
                  autocorrect: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 30),
                TextFormField(

                  cursorColor: Colors.lightBlueAccent,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  enableSuggestions: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
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
                    labelText: 'Şifre',
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen bir şifre giriniz';
                    }
                    return null;
                  },
                  onSaved: passChange,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Hesabın yok mu? ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                          ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: Text("Kayıt Ol",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 13, color: const Color(0XFF00838F))),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.only(right: 100,left: 100),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final res = await _auth.signInWithCredential(
                              email, password, context);
                          print(res);
                          if (res != null) {
                            Navigator.pop(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF01579B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        'Giriş Yap',
                        style:
                            GoogleFonts.sora(color: Colors.white, fontSize: 20),
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
