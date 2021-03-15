import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/newpost.dart';

class Posting extends StatefulWidget {
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
  build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("New Post:")),
      body: buildForm(),
    );
  }

  Widget buildPage() {
    return Container(height: 400, width: 500, child: Image.file(widget.image));
  }

  Widget buildForm() {
    return Form(
        key: _formKey,
        child: Builder(
            builder: (ctx) =>
                Column(children: <Widget>[buildBox(_formKey, ctx)])));
  }

  Widget buildField(_formKey, ctx) {
    return Semantics(
        label: "Please enter number of items wasted",
          child: SizedBox(
        height: 200,
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a number';
              }
              list.add(value);
              return null;
            },
            decoration: InputDecoration(
                hintText: "Number of Waste Items",
                labelStyle: TextStyle(color: Colors.green)),
            controller: waste,
          ),
        ),
      ),
    );
  }

  Widget buildBox(_formKey, ctx) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildPage(),
          SizedBox(
            height: 10,
          ),
          buildField(_formKey, ctx),
          Semantics(label:"Tap bottom button to submit post",child:submitButton(ctx)),
        ],
      ),
    );
  }

  Widget submitButton(ctx) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: RaisedButton.icon(
                label: Text(""),
                icon: Icon(
                  Icons.cloud_upload,
                  size: 90,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.00)),
                onPressed: () async {
                  buttonAction(ctx);
                }),
          ),
        ],
      ),
    );
  }

  void buttonAction(ctx) async {
    if (_formKey.currentState.validate()) {
      Scaffold.of(ctx).showSnackBar(SnackBar(content: Text('Processing Data')));
      var newurl = await uploadImage();
      if (newurl != null) {
        var tmp = await processData(newurl);
        if (tmp) {
          waste.clear();
          Navigator.pop(context);
          list = [];
        } else {
          Scaffold.of(ctx)
              .showSnackBar(SnackBar(content: Text('Upload Failed')));
        }
      } else {
        Scaffold.of(ctx)
            .showSnackBar(SnackBar(content: Text('Image upload Failed')));
      }
    }
  }

  Future<String> uploadImage() async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(widget.image.path);
    UploadTask uploadImage = storageReference.putFile(widget.image);
    await uploadImage;
    final url = await storageReference.getDownloadURL();
    print(url);
    return url;
  }

  processData(url) async {
    var newpost = NewPost(list[0]);
    newpost.setURL(url);
    await newpost.generateLocation();
    var lat = newpost.getlat();
    var long = newpost.getlong();
    if (lat == null || long == null) {
      return false;
    } else {
      await FirebaseFirestore.instance.collection('posts').add({
        'date': DateTime.now(),
        'imageURL': newpost.getURL(),
        'quantity': newpost.getquantity(),
        'latitude': lat,
        'longitude': long,
      });
      return true;
    }
  }
}
