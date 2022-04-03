import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oldcode/app/pages/events/event_deatil.dart';
import 'package:oldcode/app/pages/events/finishedeventsdetail.dart';

class FinishedEvents extends StatefulWidget {


  @override
  _FinishedEventsState createState() => _FinishedEventsState();
}

Future<List<Data>> fetchData() async {
  final response = await http.get(
      'https://helloworldhosur.000webhostapp.com/api/v2/finishedevents.php');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String event_id;
  final String event_name;
  final String date;
  final String image;
  final String location;
  final String register_last_date;
  final String description;


  Data({this.event_id, this.event_name, this.date, this.image,
    this.location, this.description, this.register_last_date});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      event_id: json['event_id'],
      event_name: json['event_name'],
      date: json['date'],

      image: "https://helloworldhosur.000webhostapp.com/uploads/" +  json['image'],

      location: json['location'],
      description: json['description'],
      register_last_date: json['register_last_date'],

    );
  }
}

class _FinishedEventsState extends State<FinishedEvents> {

  bool get wantKeepAlive => true;

  Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Data>>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Data> data = snapshot.data;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0.0,0.5,0.0,0.5),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Location: ${data[index].location}", style: TextStyle(color: Colors.black38,fontWeight: FontWeight.w500, fontSize: 16.0),),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0.0,12.0,0.0,12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(child: Text(data[index].event_name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),), flex: 3,),
                                    Flexible(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => FinishedeventDetail(
                                              eventName: data[index].event_name,
                                              date: data[index].date,
                                              register_last_date: data[index].register_last_date,
                                              image: data[index].image,
                                              description: data[index].description,
                                              location: data[index].location,
                                            )),
                                          );
                                        },
                                        child: Container(
                                          height: 80.0,
                                          width: 80.0,
                                          child: Image.network(
                                            "${data[index].image}",
                                            fit: BoxFit.cover,
                                          ),

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(data[index].description, style: TextStyle(fontSize: 18.0),),
                                      Text("Last Date To Apply : ${data[index].register_last_date}", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),)
                                    ],
                                  ),

                                  Row(
                                    children: [
                                      Text("read more"),
                                      Icon(Icons.arrow_right_sharp),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
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
