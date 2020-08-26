import 'package:flutter/material.dart';
import 'package:flutter_app/News.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Click on the below options'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
Future<News> createUser(int id, String name,String image) async{
  final String apiUrl = "http://k4ni5h.pythonanywhere.com/update";

  final response = await http.post(apiUrl, body: {
    "name": name,
    "image": image,
    "id": id,
  });

  if(response.statusCode == 201){
    final String image = response.body;
    return createUser(id,name,image);
  }else{
    return null;
  }
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<User>> _getUsers() async {

    var data = await http.get("http://k4ni5h.pythonanywhere.com/list");

    var jsonData = json.decode(data.body);

    List<User> users = [];

    for(var u in jsonData){

      User user = User(u["id"], u["name"],u["image"]);

      users.add(user);

    }

    print(users.length);

    return users;

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(snapshot.data);
            if(snapshot.data == null){
              return new Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        child: FlatButton(onPressed: (){
                          setState(() {
                            if (snapshot.data[index] != null) {
                              Image.asset("dp.jpg");
                            }
                          });
                        },
                            child:CircleAvatar(
                              backgroundImage: NetworkImage(
                                  snapshot.data[index].image
                              ),
                              radius: 60.0,
                            ),
                        ),

                    ),
                      Text(snapshot.data[index].name),
                    ],

                  );


                }
              );
            }
          },
        ),
      ),
    );
  }
}



class User {
  final int id;
  final String name;
  final String image;

  User(this.id, this.name, this.image);

}