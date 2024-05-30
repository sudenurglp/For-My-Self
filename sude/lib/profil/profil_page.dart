import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int counter = 0;
  String adSoyad = 'Takma Ad Girin';
  String konum = 'Lokasyon Girin';
  String sihir = 'Hangi sihire sahip olmak isterdin?';
  String hobiler = 'Hobilerin nelerdir?';
  String takim = 'Tuttuğun Takım';
  String? userId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }
  void _getUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String? displayName = user.displayName;
      if (displayName != null && displayName.isNotEmpty) {
        setState(() {
          adSoyad = displayName;
        });
      }
      userId = user.uid;
      DocumentSnapshot snapshot = await _firestore.collection('users').doc(
          userId).get();
      if (snapshot.exists) {
        setState(() {
          adSoyad = snapshot['adSoyad'] ?? 'Takma Ad Girin';
          konum = snapshot ['konum'] ?? 'Lokasyon Girin';
          sihir = snapshot ['sihir'] ?? ' Hangi sihire sahip olmak isterdin?';
          hobiler = snapshot ['Hobiler'] ?? 'Hobilerin Nelerdir?';
          takim = snapshot ['takim'] ?? 'Tuttuğun Takım';
        });
      }
    }
    }
    void _updateUserData() async {
    if (userId != null) {
      await _firestore.collection('users').doc(userId).set({
        'adSoyad' : adSoyad,
        'konum' : konum,
        'sihir' : sihir,
        'hobiler' : hobiler,
        'takim': takim,
      });
    }
  }
  void _alanDuzenle(String alan, String mevcutDeger, Function(String) kaydetmeFonksiyonu) {
    TextEditingController controller = TextEditingController(text: mevcutDeger);

        showDialog(context: context, builder: (context) => AlertDialog(
         title: Text("$alan Düzenle"),
         content: TextField(
           controller: controller,
            decoration: InputDecoration(hintText: "Yeni $alan giriniz"),
          ),
           actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("İptal"),
            ),
          TextButton(onPressed: () {
           kaydetmeFonksiyonu(controller.text);
             _updateUserData();
               Navigator.pop(context);
              },
              child: Text("Kaydet"),
            ),
           ],
          ),
         );
       }
         @override
         Widget build(BuildContext context) {
           return Scaffold(
              appBar: AppBar(
               title: Text(
                 "Profil",
                 style: TextStyle(color: Colors.white), ),
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                              onPressed: () {
                              Navigator.of(context).pop();
                            },
                         ),
                       flexibleSpace: Container(
                     decoration: BoxDecoration (
                  gradient: LinearGradient(
                  colors: [ Colors.pink[300]!,
                  Colors.blueGrey,],
                 ),
               ),
             ),
            ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                     counter = counter +1;
               });
              },
                 child: Icon(Icons.add),
                  backgroundColor: Colors.deepPurple,
                   ),
                     body: SingleChildScrollView(
                         child: Stack(
                        children: [
                            Column(
                             children: [
                               Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                   colors: [
                                    Colors.pink[300]!,
                                Colors.blueGrey,
                                   ],
                                 ),
                                ),
                                  child: Column(
                                      children: [
                                     SizedBox(height: 110.0),
                                       GestureDetector(
                                        onTap: () => _alanDuzenle('Takma Ad Gir', adSoyad, (value) {
                                         setState(() {
                                       adSoyad = value;
                                      });
                                 }),
                       child: Icon(
                               Icons.person,
                                       size: 120,
                                    color: Colors.white,
                       ),
                   ),
                                       SizedBox(height: 10.0),
                                          GestureDetector( onTap: () => _alanDuzenle('Takma Ad', adSoyad, (value) {
                                        setState(() {  adSoyad = value;
    });
  }),
                                                child: Text( adSoyad, style: TextStyle( color: Colors.white, fontSize: 15.0,
                          ),
                         ),
                        ),
                                                    SizedBox(height: 20.0),
                          ],
                         ),
                        ),
                                         Container(
                                       color: Colors.grey[200],
                                           child: Center(
                                               child: Card(
                                      margin: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                                                        child: Container( width: 310.0, height: 290.0, child: Padding( padding: EdgeInsets.all(10.0),
                                                          child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                         children: [
                                          Text("Bilgiler",style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w800,
  ),
  ),
                                         Divider(color: Colors.grey[300]),
                                        _buildInfoRow( icon: Icons.home, iconColor : Colors.blueAccent[400]!,
                                               title: "Konum",
                                               subtitle: konum,
                                                  onTap: () =>
                                              _alanDuzenle('Konum', konum, (value) {
                                               setState(() {
                                             konum = value;
                                 });
                               }),
                               ),
                                        SizedBox(height: 20.0),
                                                              _buildInfoRow(
                                                             icon: Icons.auto_awesome,
                                                                 iconColor: Colors.yellowAccent[400]!,
                                                           title: "Sihir",
                                                                 subtitle : sihir,
                                                            onTap: () =>
                                                      _alanDuzenle('Sihir', sihir, (value) {
                                                               setState(() {
                                                                 sihir = value;
                                                         });
                                                  }),
                                         ),
                                                             SizedBox(height: 20.0),
                                                        _buildInfoRow( icon: Icons.favorite, iconColor: Colors.purpleAccent[400]!,
                                                           title: "Hobiler",
                                                               subtitle: hobiler,
                                                              onTap: () =>
                                                              _alanDuzenle('Hobiler', hobiler, (value) {
                                                               setState(() {
                                                                 hobiler = value;
                                                });
                                                 }),
                                             ),
                                                               SizedBox(height: 20.0),
                                                                             _buildInfoRow( icon: Icons.people, iconColor: Colors.lightGreen[400]!,
                                                                    title: "Takım",
                                                                    subtitle: takim,
                                                            onTap: () => _alanDuzenle('Takım', takim, (value) {
                                                              setState(() {
                                                                  takim = value;
                                                              });
                                                             }),
                                                            ),
                                                           ],
                                                          ),
                                                          ),
                                                       ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                             ),
                                                   Positioned(top: MediaQuery.of(context).size.height * 0.45, left: 20.0, right: 20.0,
                                                          child: Card(
                                                              child: Padding(
                                                               padding: EdgeInsets.all(16.0),
                                                                      child: Row(
                                                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                               children: [
                                                               _buildStatistic("Bugün kaç kişiyi mutlu ettin, tıkla", "$counter"),
                                      ],
                                     ),
                                    ),
                                  ),
                                  ),
                                ],
                               ),
                             ),
                           );
                          }
                         Widget _buildInfoRow({
                          required IconData icon,
                          required Color iconColor,
                          required String title,
                          required String subtitle,
                          required VoidCallback onTap,
  }) {
                     return GestureDetector(
                            onTap: onTap,
                             child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                Icon(icon, color: iconColor, size: 35,),
                                   SizedBox(width: 20.0),
                                    Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(title, style: TextStyle(fontSize: 15.0,
                                ),
                               ),
                                        Text(subtitle, style: TextStyle(fontSize: 12.0, color: Colors.grey[400],
                                     ),
                                     ),
                                     ],
                                    ),
                                  ],
                                 ),
                                );
                               }
                       Widget _buildStatistic(String label, String value) {
                         return Container(
                                     child: Column(
                                        children: [
                                            Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 14.0,
                               ),
                              ),
                                        SizedBox(height: 5.0),
                                       Text(value, style: TextStyle(
                                       fontSize: 15.0,
                       ),),
                       ],
                     ),
                    );
               }
              }
