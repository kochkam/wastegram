import 'package:location/location.dart';

// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/models/newpost.dart';
import 'package:wastegram/main.dart';
import 'package:wastegram/models/locationservices.dart';

void main() {
  test('Post created from constructor should work',() async{
    TestWidgetsFlutterBinding.ensureInitialized();
    var now = DateTime.now();
    var post = NewPost("12",'imageURL',23.00,11.00,now);

    expect(post.getlat(), 23.00);
    expect(post.getlong(), 11.00);
    expect(post.getURL(), 'imageURL');
    expect(post.getdate(), now );
    expect(post.getquantity(), "12");
  });

  test('Post created from constructor should work and editing it using setters',() async{
    TestWidgetsFlutterBinding.ensureInitialized();
    var now = DateTime.now();
    var post = NewPost("12",'imageURL',23.00,11.00,now);
    var newdate = DateTime.now();
    post.setDate(newdate);
    post.setLat(44.00);
    post.setLong(22.00);
    post.setURL("url");
    

    expect(post.getlat(), 44.00);
    expect(post.getlong(), 22.00);
    expect(post.getURL(), 'url');
    expect(post.getdate(), newdate );
    expect(post.getquantity(), "12");
  });
}
