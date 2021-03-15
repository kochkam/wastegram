import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


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
      appBar: AppBar(title: Text("Posting Details")), //display date
      body: buildbody());
  }


  Widget buildbody(){
      var datestring = widget.post['date'].toDate().toString();
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      DateTime datetime = dateFormat.parse(datestring); 
      var formatter = new DateFormat('E, MMMM d, y').format(datetime);

      return Container(

        child: Column(
          children:[
            SizedBox(height:40.00),
            Text(formatter, style: TextStyle(fontSize: 30.00,color: Colors.white)),
            SizedBox(height:60.00),
            Container(height: 350, width: 400,child:Image.network(widget.post['imageURL'],fit: BoxFit.fill)),
            alternateBody(),
          ]
        ));

  }


Widget alternateBody(){
  return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: 300.00,
          height: 300.00,
        //color: Colors.lightBlue,
          child: Column(children:[
                  SizedBox(height:50.00),
                  Text(widget.post['quantity'].toString() + " items", style: TextStyle(fontSize: 40.00,color: Colors.white)),
                  SizedBox(height:75.00),
                  Text("Location: (" + widget.post['latitude'].toString() + ", " + widget.post['longitude'].toString() + ")", style: TextStyle(fontSize: 15.00,color: Colors.white)),
                  SizedBox(height:10.00),
        ]),
    ),
      ),
  );


}
}