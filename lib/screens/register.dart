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
    print(AuthRepository().getCurrentUser());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Register',
          style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
            child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register',
                style: GoogleFonts.robotoMono(color: Colors.green, fontSize: 30),
              ),
              const SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: nameChange,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableSuggestions: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: emailChange,
                autocorrect: true,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 5),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                enableSuggestions: false,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: passChange,
                autocorrect: false,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 5),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final res = await _auth.createUser(name, email, password, context);
                      if (res != null) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.robotoMono(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
