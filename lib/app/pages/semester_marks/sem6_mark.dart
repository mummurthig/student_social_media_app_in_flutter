import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Sem6MarkPage extends StatefulWidget {

  @override
  _Sem6MarkPageState createState() => _Sem6MarkPageState();
}


Future<List<Data>> fetchData() async {
  final response = await http.get(
      'https://helloworldhosur.000webhostapp.com/api/v2/getsemmark.php?student_id=1&sem=6');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String id;
  final String student_id;
  final String semester;
  final String subject;
  final String gained_marks;
  final String obtained_mark;


  Data({this.id, this.student_id, this.semester, this.subject, this.gained_marks, this.obtained_mark});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      student_id: json['student_id'],
      semester: json['semester'],
      subject: json['subject'],
      gained_marks: json['gained_marks'],
      obtained_mark: json['obtained_mark'],
    );
  }
}

class _Sem6MarkPageState extends State<Sem6MarkPage> with AutomaticKeepAliveClientMixin<Sem6MarkPage>{


  Future<List<Data>> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Student Mark Details'),
      ),
      body: Center(
        child: FutureBuilder<List<Data>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Data> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Row(
                            children: <Widget>[
                              Expanded(child: Text(data[index].subject, style: TextStyle(fontWeight: FontWeight.bold),)),
                              SizedBox(
                                width: 16.0,
                              ),
                              Text(
                                "Total Mark: ${data[index].obtained_mark}",
                                style: TextStyle(fontSize: 13.0),
                              ),
                            ],
                          ),
                          subtitle: Text("Obtained Mark : ${data[index].gained_marks}", style: TextStyle(fontWeight: FontWeight.bold),),

                        ),
                      ],
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
