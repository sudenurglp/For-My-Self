import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sude/home/game/game_page.dart';
import 'package:sude/home/mood/mood_page.dart';
import 'package:sude/home/notes/note_page.dart';
import 'package:sude/home/additions/category_button.dart';
import 'package:sude/home/drawer.dart';
import 'package:sude/home/planner/planner_page.dart';
import 'package:sude/profil/profil_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

 class _HomePageState extends State<HomePage> {
   final currenUser = FirebaseAuth.instance.currentUser!;
   String? displayName;
   bool showWelcomeMessage = false;

   final List<Map<String, dynamic>> categoryList = [
     {'category': 'Notlar', 'icon': Icons.note},
     {'category': 'Mood', 'icon': Icons.note},
     {'category': 'Planlayıcı', 'icon': Icons.share_arrival_time_outlined},
     {'category': 'Oyun Zamanı', 'icon': Icons.gamepad_outlined},
   ];

   @override
   void initState() {
     super.initState();
     fetchUserName();
   }

   Future<void> fetchUserName() async {
     final userDoc = await FirebaseFirestore.instance
         .collection('users')
         .doc(currenUser.email)
         .get();
     if (userDoc.exists) {
       setState(() {
         displayName = userDoc.data()?['username'] ?? 'User';
       });
       Future.delayed(Duration(seconds: 2), () {
         setState(() {
           showWelcomeMessage = false;
         });
       });
     }
   }

   void goToProfilPage() {
     Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()),
     );
   }

   void signOut() {
     FirebaseAuth.instance.signOut();
     Navigator.of(context).pop();
   }

   void goToNotePage() {
     Navigator.push(
       context, MaterialPageRoute(builder: (context) => NotePage()),
     );
   }

   void goToMoodPage() {
     Navigator.push(
       context, MaterialPageRoute(builder: (context) => MoodPage()),
     );
   }

   void goToPlannerPage() {
     Navigator.push(
       context, MaterialPageRoute(builder: (context) => PlannerPage()),
     );
   }

   void goToGamePage() {
     Navigator.push(
       context, MaterialPageRoute(builder: (context) => GamePage()),
     );
   }

   void goToCategoryPage(String category) {
     Navigator.push(context, MaterialPageRoute(
         builder: (context) => CategoryPage(category: category)),
     );
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.grey[300],
       appBar: AppBar(
         backgroundColor: Colors.deepPurple[300],
         title: Text(
           "Anasayfa", style: TextStyle(color: Colors.white),
         ),
       ),
       drawer: MyDrawer(
         onProfilTap: goToProfilPage,
         onSignOut: signOut,
       ),
       body: Column(
         children: [
           if (showWelcomeMessage && displayName != null)
             Padding(padding: const EdgeInsets.all(8.0),
               child: Text("Hoşgeldin! $displayName",
                 selectionColor: Colors.blueGrey,
                 style: TextStyle(fontSize: 16,
                   fontStyle: FontStyle.italic,
                 ),
               ),
             ),
           Padding(padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text('Kategori Seçin',
                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                   ),
                 ),
               ],
             ),
           ),
           Expanded(
             child: GridView.builder(itemCount: categoryList.length,
               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.9,
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 12,
               ),
               itemBuilder: (context, index) {
                 final categoryData = categoryList[index];
                 return CategoryButton(category: categoryData['category'],
                   icon: categoryData['icon'],
                   onTap: () {
                     if (categoryData['category'] == 'Notlar') {
                       goToNotePage();
                     } else if (categoryData['category'] == 'Mood') {
                       goToMoodPage();
                     } else if (categoryData['category'] == 'Planlayıcı') {
                       goToPlannerPage();
                     } else if (categoryData['category'] == 'Oyun Zamanı') {
                       goToGamePage();
                     } else {
                       goToCategoryPage(categoryData['category']);
                     }
                   },
                 );
               },
             ),
           ),
           const SizedBox(height: 20),
           if (displayName == null && !showWelcomeMessage)
             CircularProgressIndicator(),
         ],
       ),
     );
   }
 }
 class CategoryPage extends StatelessWidget {
  final String category;
  const CategoryPage({Key? key, required this.category}) : super(key: key);
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('Category Page: $category'),
      ),
    );
  }
}
