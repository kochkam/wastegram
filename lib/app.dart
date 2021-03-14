
import 'package:flutter/material.dart';
import './widgets/listview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/posting.dart';
import 'dart:io';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: List(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Semantics(hint: "Tap to add Entry",child:FloatingActionButton(
      child: Icon(Icons.camera),
      onPressed: () async { newpost(context);})),
     );
//.then(Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Posting())))},);
  }
     // This trailing comma makes auto-formatting nicer for build methods.
  }

  newpost(context) async {
    var _picker = ImagePicker();
    var pickedFile = await _picker.getImage(source: ImageSource.gallery);
    var finalimage = File(pickedFile.path);
    if(pickedFile == null){
      return; 
    }
    else{
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => Posting(finalimage)));
    }


}