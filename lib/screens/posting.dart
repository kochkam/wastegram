
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/locationservices.dart';


class Posting extends StatefulWidget{
  final image; 
  Posting(this.image);

  @override
  _PostingState createState() => _PostingState();
}

class _PostingState extends State<Posting> {
    final _formKey = GlobalKey<FormState>();
  final waste = TextEditingController();
  var list = [];
  @override
  build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text("Todays Waste:")),
      body: buildForm(),
    );
  }

  Widget buildPage(){
    return Column(children: [Container(child: Image.file(widget.image)),
    ]);
  }

  Widget buildForm() {
    return SingleChildScrollView(
      child:Form(
        key: _formKey,
        child: Builder(builder:(ctx) => Column(
            children: <Widget>[buildBox(_formKey,ctx)])
    )));
  }

  Widget buildField(_formKey,ctx){
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if(value.isEmpty){
          return 'Please enter a number';
        }
        list.add(value);
        return null; 
      },
      decoration: InputDecoration(
        labelText: "Waste Amount",
        labelStyle: TextStyle(color: Colors.green) ),
      controller: waste,
    );
  }

  Widget buildBox(_formKey,ctx){
     return Padding(
        padding: EdgeInsets.all(10.00),
        child: Container(
      child: Column(
        children: [
          buildPage(),
          SizedBox(height: 10,),
          buildField(_formKey,ctx),
          SizedBox(height:10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            submitButton(ctx)
            ],
          )
        ],
      ),
    ));

  }


    Widget submitButton(ctx){
    return FloatingActionButton.extended(
                heroTag: "btn2",
                label: Text('Submit'),
                icon: Icon(Icons.add),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                onPressed: () async{
                  if (_formKey.currentState.validate()) {
                    Scaffold.of(ctx).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                        var newurl = await uploadImage();
                        if(newurl != null){
                        var tmp = await processData(newurl);
                        if(tmp){
                        waste.clear(); 
                        Navigator.pop(context);
                        list = []; }
                        else{
                           Scaffold.of(ctx).showSnackBar(
                          SnackBar(content: Text('Upload Failed')));
                        }
                        }
                        else{
                          Scaffold.of(ctx).showSnackBar(
                          SnackBar(content: Text('Image upload Failed')));
                        }
                  }
                },
              );

  }


Future<String> uploadImage() async {
    Reference storageReference = FirebaseStorage.instance.ref().child(widget.image.path); 
    UploadTask uploadImage = storageReference.putFile(widget.image);
    await uploadImage; 
    final url = await storageReference.getDownloadURL(); 
    print(url); 
    return url; 

  }

  processData(url) async {
    var location = WasteLocation();
    var latlong = await location.getlocation(); 

    if (latlong == null) {
      return false;
    }
    else{
    
    await FirebaseFirestore.instance.collection('posts').add({
      'date':DateTime.now(),
      'imageURL':url,
      'quantity':list[0],
      'latitude':latlong.latitude,
      'longitude':latlong.longitude,
    });
    return true; }

  }

  }
