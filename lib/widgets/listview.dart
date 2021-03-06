import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../screens/detailview.dart';

class List extends StatelessWidget {
  @override
  build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance //get firebase store data from posts collection build if data otherwise display indicator
          .collection('posts')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.data.docs != null &&
            snapshot.data.docs.length > 0) {
          return myresults(snapshot);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  myresults(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index) {
        var post = snapshot.data.docs[index];
        var datestring = post['date'].toDate().toString();  //format date info
        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        DateTime datetime = dateFormat.parse(datestring);
        var formatter = new DateFormat('EEEE, MMMM d, y').format(datetime);
        return Semantics(
          label: "Tap for details",
          onLongPressHint: "Tap for details",
          child: Card(
            color: Colors.teal[300],
            child: ListTile(
              title: Text(formatter),
              trailing: Text(post['quantity'].toString()), //display tile info
              onTap: () => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => NewDetails(post)))
              },
            ),
          ),
        );
      },
    );
  }
}
