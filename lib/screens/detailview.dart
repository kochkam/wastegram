import 'package:flutter/material.dart';


class NewDetails extends StatefulWidget {
  final post; 
  NewDetails(this.post);
  @override
  State<StatefulWidget>createState() => View();
}

class View extends State<NewDetails> {
  int counter; 
  Future<dynamic> count; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post['date'].toDate().toString())), //display date
      body: buildbody());
  }


  Widget buildbody(){
      return Container(

        child: Column(
          children:[
            Image.network(widget.post['imageURL']),
            SizedBox(height:10.00),
            Text("Item Count: " + widget.post['quantity'].toString()),
            SizedBox(height:10.00),
            Text("Latitude: " + widget.post['latitude'].toString()),
            SizedBox(height:10.00),
            Text("Longitude: " + widget.post['longitude'].toString())
          ]
        ));

  }
}