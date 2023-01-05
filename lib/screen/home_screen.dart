import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note/screen/note_editor.dart';
import 'package:note/screen/note_reader.dart';
import 'package:note/style/app_style.dart';
import 'package:note/widget/note_card.dart';
import 'package:flutter/src/material/icons.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var sizedBox = SizedBox();
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(elevation: 0.0,
       title: Text("Firenotes"), 
       centerTitle: true,
       backgroundColor: AppStyle.mainColor,
       ),

       body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Your recent Notes", style: GoogleFonts.roboto(
          color: Colors.white, 
          fontWeight: FontWeight.bold,
          fontSize: 22,
          ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
               FirebaseFirestore.instance.collection("Notes").snapshots(),
              builder:(context, AsyncSnapshot snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    
            );
          
                  }
          
                  if (snapshot.hasData){   
                    return GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                      children: snapshot.data!.docs.map((note) => noteCard((){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NoteReaderScreen(note)));
                      }, note))
                      .toList(),
                      );
                                   }
              return Text("There is no Notes", style: GoogleFonts.nunito(color: Colors.white),);
            },
          ),
        )
       ],
      ),
      // ignore: prefer_const_constructors
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.push(context, 
       MaterialPageRoute(builder: (context) => NoteEditorScreen()));
      },
       
       label: Text("Add Note"),
      icon: Icon(Icons.add),
    ),
    );
  }
}