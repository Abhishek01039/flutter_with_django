import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterweb2/model/user.dart';
import 'package:http/http.dart' as http;

Future main() async {
  // runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primarySwatch: Colors.teal,
        textTheme: TextTheme(
          body1: TextStyle(),
          button: TextStyle(),
          body2: TextStyle(),
        ).apply(
          bodyColor: Colors.blue,
          displayColor: Colors.orange,
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: "Flutter",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<User> user = new List<User>();
  _getData() async {
    try {
      String username = 'abhishek';
      String password = '1234';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      print(basicAuth);
      var response =
          // await Dio().get("http://127.0.0.1:8000/apiauth/users/");
          await http.get('http://192.168.29.182:8000/apiauth/users/',
              headers: {'authorization': basicAuth});

      var res = json.decode(response.body);
      print(res);
      setState(() {
        for (var i in res) {
          // print(i);
          user.add(User.fromJson(i));
        }
      });

      // print(u);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("data"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(user[index].firstName[0]),
              ),
              title: Text(user[index].firstName),
              subtitle: Text(user[index].lastName),
            );
          },
        ),
      ),
    );
  }
}
