import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sude/home/home_page.dart';
import 'login.dart';

class AuthService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> signUp({required BuildContext context, required String adsoyad, required String eposta, required String sifre}) async {
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(eposta)) {
      Fluttertoast.showToast(msg: "Geçerli bir e-posta adresi girin", toastLength: Toast.LENGTH_LONG);
      return;
    }
    try {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: eposta, password: sifre);
      if (userCredential.user != null) {
        await _registerUser(adsoyad: adsoyad, eposta: eposta, sifre: sifre);
        Fluttertoast.showToast(msg: "Kayıt başarılı"
            , toastLength: Toast.LENGTH_LONG);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Bu e-posta başka bir hesapla kayıtlı", toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "Şifre en az 6 karakter içermelidir", toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
      }
    }
  }

  Future<bool> signIn({required BuildContext context, required String email, required String password}) async {
    try {
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Fluttertoast.showToast(msg: "Giriş başarılı", toastLength: Toast.LENGTH_LONG);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: "Geçerli bir e-posta adresi girin", toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Bu e-posta ile kayıtlı bir kullanıcı bulunamadı", toastLength: Toast.LENGTH_LONG);
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Yanlış şifre", toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(msg: e.message!, toastLength: Toast.LENGTH_LONG);
      }
    }
    return false;
  }

  Future<void> _registerUser({required String adsoyad, required String eposta, required String sifre}) async {
    await userCollection.doc(eposta).set({
      "email": eposta,
      "username": adsoyad,
      "password": sifre
    });
  }

  }
