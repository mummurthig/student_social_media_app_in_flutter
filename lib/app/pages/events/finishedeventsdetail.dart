import 'package:flutter/material.dart';

class FinishedeventDetail extends StatefulWidget {
  final eventName;
  final date;
  final image;
  final location;
  final register_last_date;
  final description;

  FinishedeventDetail({this.eventName, this.date, this.description, this.location, this.register_last_date, this.image});

  @override
  _FinishedeventDetailState createState() => _FinishedeventDetailState();
}

class _FinishedeventDetailState extends State<FinishedeventDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                widget.image, // this image doesn't exist
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.amber,
                    alignment: Alignment.center,
                    child: Text('Whoops!', style: TextStyle(fontSize: 30),),
                  );
                },
              ),
            ),
            Divider(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.eventName, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.date, style: TextStyle(fontSize: 16.0),)),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.register_last_date, style: TextStyle(fontSize: 16.0),)),
                ),
              ],
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Description", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),)),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.description, textAlign: TextAlign.center, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold, ),)),
            ),
          ],
        ),
      ),
    );
  }
}
