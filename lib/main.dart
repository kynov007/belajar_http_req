// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late String name;
//   late String email;

//   @override
//   void initState() {
//     name = '';
//     email = '';
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('belajar http req'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Nama : ${name}'),
//             SizedBox(
//               height: 10,
//             ),
//             Text('Email : ${email}'),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: 200,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   var myrepon = await http
//                       .get(Uri.parse('https://reqres.in/api/users/2'));
//                   print(myrepon.statusCode);
//                   if (myrepon.statusCode == 200) {
//                     setState(() {
//                       var data =
//                           json.decode(myrepon.body) as Map<String, dynamic>;
//                       name =
//                           '${data['data']['first_name']} ${data['data']['last_name']}';
//                       email = data['data']['email'].toString();
//                       print(data['support']);
//                     });
//                   } else {
//                     final snackBar = SnackBar(
//                         content: Container(
//                       child: Text(
//                         'Error : ${myrepon.statusCode}',
//                         style: TextStyle(fontSize: 20),
//                       ),
//                     ));
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   }
//                 },
//                 child: Text('klik'),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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
  TextEditingController NameC = TextEditingController();
  TextEditingController JobC = TextEditingController();

  late String hasil;
  late String jobs;
  late String waktu;
  @override
  void initState() {
    hasil = 'Tidak ada hasil';
    jobs = '';
    waktu = '';
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Http Post'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, top: 50),
                child: Text(
                  'Nama',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: NameC,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 20),
                child: Text(
                  'Job',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: JobC,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.work),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    var myResponse = await http.post(
                      Uri.parse('https://reqres.in/api/users'),
                      body: {
                        "name": NameC.text,
                        "job": JobC.text,
                      },
                    );
                    print(myResponse.body);
                    if (myResponse.statusCode == 201) {
                      setState(() {
                        var data = json.decode(myResponse.body)
                            as Map<String, dynamic>;
                        hasil = 'Nama saya ${data['name'.toString()]}';
                        jobs =
                            'Pekerjaan saya Adalah ${data['job'.toString()]}';
                        waktu = 'Dibuat pada ${data["createdAt".toString()]}';
                      });
                    }
                  },
                  child: Text('Login'),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                hasil,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                jobs,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                waktu,
                style: TextStyle(fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
