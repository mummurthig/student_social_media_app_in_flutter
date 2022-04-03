import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final String id, title, tag , postBy, subTitle, content, dateAndTime, image;
  PostDetail({this.id, this.title, this.tag, this.subTitle, this.postBy, this.content, this.dateAndTime, this.image});

  @override
  _PostDetailState createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 250.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                actions: [
                  IconButton(icon: Icon(Icons.share, color: Colors.black,), onPressed: (){}),
                ],
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image.network(
                      "${widget.image}",
                      fit: BoxFit.cover,
                    )),
              ),

            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  child: new Text(
                    'POST BY : ${widget.postBy}',
                    style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
                    textAlign: TextAlign.left,
                  ),
                  padding: EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
                ),
                Padding(
                  child: new Text(
                    '${widget.title}',
                    style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0),
                    textAlign: TextAlign.justify,
                  ),
                  padding: EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
                ),
                Padding(
                  child: new Text(
                    '${widget.subTitle}',
                    style: new TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),
                    textAlign: TextAlign.justify,
                  ),
                  padding: EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
                ),
                Padding(
                  child: new Text(
                    '${widget.content}',
                    style: new TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.justify,
                  ),
                  padding: EdgeInsets.only(bottom: 20.0, top: 20.0, left: 10.0, right: 10.0),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}


