import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:oldcode/app/pages/home_page.dart';
import 'package:oldcode/app/pages/news/post_detail.dart';

class NewsBlog extends StatefulWidget {
  @override
  _NewsBlogState createState() => _NewsBlogState();
}

class _NewsBlogState extends State<NewsBlog> with AutomaticKeepAliveClientMixin<NewsBlog>{

  Future<List<PostData>> listDataJSON() async {
    final url = 'https://helloworldhosur.000webhostapp.com/api/v2/all_posts.php';
    final response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      List listData = json.decode(response.body);
      return listData
          .map((listData) => new PostData.fromJson(listData))
          .toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<Null> refresh() async {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (a, b, c) => HomePage(),
        transitionDuration: Duration(seconds: 0),
      ),
    );
    return;
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: refresh,
      child: FutureBuilder<List<PostData>>(
        future: listDataJSON(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                padding: EdgeInsets.only(top:9),
                itemBuilder: (BuildContext context, int currentIndex) {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            snapshot.data[currentIndex].postBy,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              "@ ${snapshot.data[currentIndex].tag}",
                                              style: TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(top: 0.0, bottom: 8.0),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => PostDetail(
                                            id: snapshot.data[currentIndex].id,
                                            title: snapshot.data[currentIndex].title,
                                            subTitle: snapshot.data[currentIndex].subTitle,
                                            tag: snapshot.data[currentIndex].tag,
                                            postBy: snapshot.data[currentIndex].postBy,
                                            dateAndTime: snapshot.data[currentIndex].dateAndTime,
                                            content: snapshot.data[currentIndex].content,
                                            image: snapshot.data[currentIndex].image,
                                          )),
                                        );
                                      },
                                      child: Text(
                                        snapshot.data[currentIndex].title,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: snapshot.data[currentIndex].image == null
                                        ? null
                                        : InkWell(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => PostDetail(
                                            id: snapshot.data[currentIndex].id,
                                            title: snapshot.data[currentIndex].title,
                                            subTitle: snapshot.data[currentIndex].subTitle,
                                            tag: snapshot.data[currentIndex].tag,
                                            postBy: snapshot.data[currentIndex].postBy,
                                            dateAndTime: snapshot.data[currentIndex].dateAndTime,
                                            content: snapshot.data[currentIndex].content,
                                            image: snapshot.data[currentIndex].image,
                                          )),
                                        );
                                      },
                                          child: Container(
                                      width: double.infinity,
                                      child: ClipRRect(
                                            borderRadius: BorderRadius.circular(2.0),
                                            child: Image.network(snapshot.data[currentIndex].image)),
                                    ),
                                        ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                                height: 19.0,
                                                width: 300,
                                                child: Text(
                                                  "Posted on : ${snapshot.data[currentIndex].dateAndTime}",
                                                  style: TextStyle(color: Colors.black),
                                                )),

                                          ],
                                        ),

                                      ],
                                    ),
                                  ),

                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(5, 0, 16, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 18.0,
                                              width: 18.0,
                                              child: IconButton(
                                                padding: new EdgeInsets.all(0.0),
                                                icon: Icon(
                                                  Icons.favorite_border,
                                                  size: 19.0,
                                                  color: Colors.black54,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(height: 2.0,),
                                            SizedBox(
                                              child: Text("Like", style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w600),),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 18.0,
                                              width: 18.0,
                                              child: IconButton(
                                                padding: new EdgeInsets.all(0.0),
                                                icon: Icon(
                                                  Icons.share_sharp,
                                                  size: 19.0,
                                                  color: Colors.black54,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(height: 2.0,),
                                            SizedBox(
                                              child: Text("Share",style: TextStyle(fontSize: 13.0,fontWeight: FontWeight.w600),),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 18.0,
                                              width: 18.0,
                                              child: IconButton(
                                                padding: new EdgeInsets.all(0.0),
                                                icon: Icon(
                                                  Icons.save_outlined,
                                                  size: 19.0,
                                                  color: Colors.black54,
                                                ),
                                                onPressed: () {},
                                              ),
                                            ),
                                            SizedBox(height: 2.0,),
                                            SizedBox(
                                              child: Text("Save",style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600),),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 7.8, child: Container(
                        color: Colors.grey[300],
                      ),),

                    ],
                  );
                });
          }
        },
      ),
    );
  }
}


class PostData {
  final String id;
  final String title;
  final String tag;
  final String postBy;
  final String subTitle;
  final String content;
  final String dateAndTime;
  final String image;

  PostData({this.id, this.title, this.tag, this.postBy, this.subTitle, this.content, this.dateAndTime, this.image});
  factory PostData.fromJson(Map<String, dynamic> jsonData) {
    return PostData(
      id: jsonData['id'],
      title: jsonData['title'],
      tag: jsonData['tag'],
      postBy: jsonData['post_by'],
      subTitle: jsonData['sub_title'],
      content: jsonData['content'],
      dateAndTime: jsonData['dateandtime'],
      image: "https://helloworldhosur.000webhostapp.com/uploads/" +  jsonData['image'],
    );
  }
}


