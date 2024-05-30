import 'package:flutter/material.dart';
import 'package:sude/Authtentication/auth_service.dart';
import 'package:sude/Authtentication/signup.dart';
import 'package:sude/home/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final eposta = TextEditingController();
  final sifre = TextEditingController();
  final adsoyad = TextEditingController();
  bool isVisible = false;
  bool isLoginTrue = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/assets/fms.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset("lib/assets/programmer.png", width: 210),
                      const SizedBox(height: 15),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2),
                        ),
                        child: TextFormField(
                          controller: adsoyad,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ad Soyad Gerekli";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            border: InputBorder.none,
                            hintText: "Ad Soyad",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2),
                        ),
                        child: TextFormField(
                          controller: eposta,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "E posta Gerekli";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            icon: Icon(Icons.email),
                            border: InputBorder.none,
                            hintText: "E Posta",
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple.withOpacity(.2),
                        ),
                        child: TextFormField(
                          controller: sifre,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Şifre Gerekli";
                            }
                            return null;
                          },
                          obscureText: !isVisible,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Şifre",
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(
                                isVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * .9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.deepPurple,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              bool result = await AuthService().signIn(
                                context: context,
                                email: eposta.text,
                                password: sifre.text,
                              );
                              setState(() {
                                isLoginTrue = !result;
                              });
                            }
                          },
                          child: const Text(
                            "Giriş Yap",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Hesabın Yok Mu?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUp()),
                              );
                            },
                            child: const Text("Kaydol"),
                          ),
                        ],
                      ),
                      isLoginTrue
                          ? const Text(
                        "Kullanıcı Adı Veya Şifre Yanlış",
                        style: TextStyle(color: Colors.red),
                      )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
