import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  _fetchData() async {
    final response = await http.get(
        'http://5d0ebbc0.ngrok.io/api/entries?location=32.857666,13.208999');

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pollution Rate near you is:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data['pollution_rate'].toString() + '%',
                    style: TextStyle(fontSize: 40),
                  );
                } else {
                  return Text("${snapshot.error}");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
