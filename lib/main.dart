import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name;
  late String email;

  @override
  void initState() {
    name = '';
    email = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('belajar http req'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Nama : ${name}'),
            SizedBox(
              height: 10,
            ),
            Text('Email : ${email}'),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  var myrepon = await http
                      .get(Uri.parse('https://reqres.in/api/users/2'));
                  print(myrepon.statusCode);
                  if (myrepon.statusCode == 200) {
                    setState(() {
                      var data =
                          json.decode(myrepon.body) as Map<String, dynamic>;
                      name =
                          '${data['data']['first_name']} ${data['data']['last_name']}';
                      email = data['data']['email'].toString();
                      print(data['support']);
                    });
                  } else {
                    final snackBar = SnackBar(
                        content: Container(
                      child: Text(
                        'Error : ${myrepon.statusCode}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text('klik'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
