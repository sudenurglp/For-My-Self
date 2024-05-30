import 'package:flutter/material.dart';
import 'package:sude/Authtentication/login.dart';

import 'additions/My_List_Tile.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onProfilTap;
  final void Function()? onSignOut;
  const MyDrawer({super.key, required this.onProfilTap, required this.onSignOut,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Column(
           children: [
           const DrawerHeader(child: Icon(Icons.person, color: Colors.white,
             size: 64,),
           ),

           MyListTile(icon: Icons.home, text: 'A N A S A Y F A',
             onTap: () => Navigator.pop(context),
           ),

           MyListTile(icon: Icons.person, text: 'P R O F İ L',
             onTap: onProfilTap,
           ),
         ],
         ),

          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(icon: Icons.logout, text: 'Ç I K I Ş',
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
            ),
          ),

        ],
      )
    );
  }
}
