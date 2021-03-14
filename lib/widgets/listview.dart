import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import '../screens/detailview.dart';

class List extends StatelessWidget{

  @override
  build(BuildContext context){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('posts').orderBy('date',descending: true).snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData && snapshot.data.docs != null && snapshot.data.docs.length > 0){
          return myresults(snapshot);
        }
        else{
          return CircularProgressIndicator();
        }
      },);



  }




myresults(snapshot){
  return ListView.builder(
    itemCount: snapshot.data.docs.length,
    itemBuilder: (context,index){
      var post = snapshot.data.docs[index];
      return Semantics(
        label:"Tap for deatils",
        onLongPressHint: "Tap for details",
              child: ListTile(
          title: Text(post['date'].toDate().toString()),
          leading: Text(post['quantity'].toString()),
          onTap: () => { Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => NewDetails(post)))},
        ),
      );
    },
  );

}




}

