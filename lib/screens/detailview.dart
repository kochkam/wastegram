import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/scrollabledetails.dart';

class NewDetails extends StatefulWidget {
  final post;
  NewDetails(this.post);
  @override
  State<StatefulWidget> createState() => View();
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

  Widget buildbody() {
    var datestring = widget.post['date'].toDate().toString();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime datetime = dateFormat.parse(datestring);
    var formatter = new DateFormat('E, MMMM d, y').format(datetime);  //format date

    return Container(
        child: Column(children: [
      SizedBox(height: 40.00),
      Text(formatter, style: TextStyle(fontSize: 30.00, color: Colors.white)),
      SizedBox(height: 60.00),
      Container(
          height: 350, //display image
          width: 400,
          child: Image.network(widget.post['imageURL'], fit: BoxFit.fill)),
      Details(widget.post),
    ]));
  }
}
