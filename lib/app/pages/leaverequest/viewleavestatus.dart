import 'package:flutter/material.dart';

class ViewLeaveStatus extends StatefulWidget {

  final String request_date;
  final String leave_days;
  final String status;
  final String start_date;
  final String end_date;
  final String reason_for_leave;
  final String reason_for_disapproved;

  ViewLeaveStatus({this.request_date, this.leave_days, this.status, this.start_date, this.end_date, this.reason_for_disapproved, this.reason_for_leave});

  @override
  _ViewLeaveStatusState createState() => _ViewLeaveStatusState();
}

class _ViewLeaveStatusState extends State<ViewLeaveStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leave Details"),
      ),
      body: Container(
        margin: EdgeInsets.all(10) ,
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Leave Applied: ${widget.request_date}', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Leave Days: ${widget.leave_days}', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Start Date: ${widget.start_date}', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Leave Applied: ${widget.end_date}', style: TextStyle(fontWeight: FontWeight.bold),),
                  ),

                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Reason For Leave', style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(widget.reason_for_leave),
                  ),

                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Reason For Disapproved' , style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text(widget.reason_for_disapproved,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
