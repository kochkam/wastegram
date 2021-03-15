import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final post;
  Details(this.post);
  @override
  build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: 300.00,
          height: 300.00,
          child: Column(children: [
            SizedBox(height: 50.00),
            Text(post['quantity'].toString() + " items",
                style: TextStyle(fontSize: 40.00, color: Colors.white)),
            SizedBox(height: 75.00),
            Text(
                "Location: (" +
                    post['latitude'].toString() +
                    ", " +
                    post['longitude'].toString() +
                    ")",
                style: TextStyle(fontSize: 15.00, color: Colors.white)),
            SizedBox(height: 10.00),
          ]),
        ),
      ),
    );
  }
}
