import 'dart:js';
import 'dart:wasm';

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:toast/toast.dart';

void main() {
  runApp(MaterialApp(
    home: Myapp(),
  ));
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

var fs = FirebaseFirestore.instance;

var cmd;
var val;
String data;
String dockercmd;

myweb() async {
  var url = "http://192.168.43.109/cgi-bin/web.py?x=${cmd}";
  //var url = "http://192.168.43.105/cgi-bin/api.py?x=${cmd}";

  var x = await http.get(url);
  val = x.body;
  print(val);
  fs.collection("output").add({});
}

mydata() async {
  var data = fs.collection("output").get();
  print(data);
}

class _MyappState extends State<Myapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('firebase app'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        //decoration: BoxDecoration(
        //image: DecorationImage(
        //image: AssetImage("images/backgrd1.jpg"), fit: BoxFit.fill)),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/docker.jpg"),
                      fit: BoxFit.fill)),
              padding: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: TextField(
                onChanged: (value) {
                  cmd = value;
                },
                cursorColor: Colors.red,
                style: TextStyle(color: Colors.blue),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.cyan),
                    hintText: "Enter the command",
                    contentPadding: EdgeInsets.all(10),
                    hintStyle: TextStyle(color: Colors.amber)),
              ),
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                    onPressed: myweb,
                    child: Text("RUN"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(5),
                  ),
                  
                  FlatButton(
                    onPressed: mydata,
                    child: Text("Output"),
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                data ?? "output is coming!!",
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.cyan[100]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
