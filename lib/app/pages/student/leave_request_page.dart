import 'package:flutter/material.dart';
import 'package:oldcode/app/pages/events/all_events.dart';
import 'package:oldcode/app/pages/events/finished_events.dart';
import 'package:oldcode/app/pages/events/pending_events.dart';
import 'package:oldcode/app/pages/leaverequest/appliedleavelist.dart';
import 'package:oldcode/app/pages/leaverequest/applyforleave.dart';
import 'package:oldcode/app/pages/news/news_blog.dart';

class LeaveRequestPage extends StatefulWidget {

  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                title: Text('Leave', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),),
                shadowColor: Colors.green,

                backgroundColor: Colors.green,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontSize: 16.0,color: Colors.grey),
                  indicatorColor: Colors.green,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2.5),
                      insets: EdgeInsets.symmetric(horizontal:16.0)
                  ),
                  tabs: [
                    Tab(text: 'LEAVE APPLY'),
                    Tab(text: 'LEAVE STATUS'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ApplyForLeave(),
              AppliedLeaveList()
            ],
          ),
        ),
      ),
    );
  }
}
