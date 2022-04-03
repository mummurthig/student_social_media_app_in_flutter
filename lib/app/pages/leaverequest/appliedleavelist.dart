import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:oldcode/app/pages/leaverequest/viewleavestatus.dart';

class AppliedLeaveList extends StatefulWidget {


  @override
  _AppliedLeaveListState createState() => _AppliedLeaveListState();
}

Future<List<Data>> fetchData() async {
  final response = await http.get(
      'https://helloworldhosur.000webhostapp.com/api/v2/getleavestaus.php?student_id=1');
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  final String id;
  final String request_date;
  final String leave_days;
  final String status;
  final String start_date;
  final String end_date;
  final String reason_for_leave;
  final String reason_for_disapproved;


  Data({this.id, this.request_date, this.leave_days, this.status, this.start_date, this.end_date, this.reason_for_disapproved, this.reason_for_leave});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      request_date: json['request_date'],
      leave_days: json['leave_days'],
      status: json['status'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      reason_for_leave: json['reason_for_leave'],
      reason_for_disapproved: json['reason_for_disapproved'],
    );
  }
}

class _AppliedLeaveListState extends State<AppliedLeaveList> with AutomaticKeepAliveClientMixin<AppliedLeaveList> {

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
                              Text("Requested Date: ${data[index].request_date}", style: TextStyle(fontWeight: FontWeight.bold),),
                              SizedBox(
                                width: 16.0,
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => ViewLeaveStatus(
                                        request_date: data[index].request_date,
                                        start_date: data[index].start_date,
                                        end_date: data[index].end_date,
                                        leave_days: data[index].leave_days,
                                        reason_for_disapproved: data[index].reason_for_disapproved,
                                        reason_for_leave: data[index].reason_for_leave,

                                    )),
                                  );
                                },
                                child: Text(
                                  "view details",
                                  style: TextStyle(fontSize: 13.0, color: Colors.green),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text("Status: ${data[index].status}", style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Divider(),
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
