import 'dart:async';
import 'package:oldcode/app/pages/semester_marks/sem1_mark.dart';
import 'package:oldcode/app/pages/semester_marks/sem2_mark.dart';
import 'package:oldcode/app/pages/student/leave_request_page.dart';
import 'package:oldcode/app/pages/student/student_home.dart';
import 'package:oldcode/app/pages/student/student_mark_page.dart';
import 'package:oldcode/app/pages/student/student_profile.dart';
import 'package:oldcode/app/utils/auth_utils.dart';
import 'package:oldcode/app/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
	static final String routeName = 'home';

	@override
	State<StatefulWidget> createState() {
		return new _HomePageState();
	}

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage>{
	GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
	Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

	SharedPreferences _sharedPreferences;
	var _authToken, _id, _name, _homeResponse;

	@override
	void initState() {
		super.initState();
		_fetchSessionAndNavigate();
	}

	_fetchSessionAndNavigate() async {
		_sharedPreferences = await _prefs;
		String authToken = AuthUtils.getToken(_sharedPreferences);
		var id = _sharedPreferences.getString(AuthUtils.userIdKey);
		var name = _sharedPreferences.getString(AuthUtils.nameKey);

		print(authToken);

		_fetchHome(authToken);

		setState(() {
			_authToken = authToken;
			_id = id;
			_name = name;
		});

		if(_authToken == null) {
			_logout();
		}
	}

	_fetchHome(String authToken) async {
		var responseJson = await NetworkUtils.fetch(authToken);

		if(responseJson == null) {

			NetworkUtils.showSnackBar(_scaffoldKey, 'Something went wrong!');

		} else if(responseJson == 'NetworkError') {

			NetworkUtils.showSnackBar(_scaffoldKey, null);

		} else if(responseJson['errors'] != null) {

			_logout();

		}

		setState(() {
		  _homeResponse = responseJson.toString();
		});
	}

	_logout() {
		NetworkUtils.logoutUser(_scaffoldKey.currentContext, _sharedPreferences);
	}

	int _currentIndex = 0;
	final List<Widget> _children = [
		StudentHomePage(),
		StudentMarksPage(),
		LeaveRequestPage(),
		StudentProfile(),
	];

	void onTappedBar(int index){
		setState(() {
			_currentIndex = index;
		});
	}

	bool get wantKeepAlive => true;

	@override
	Widget build(BuildContext context) {
		super.build(context);
		return new Scaffold(
			key: _scaffoldKey,
				bottomNavigationBar: BottomNavigationBar(
					selectedItemColor: Colors.green.shade500,
					type: BottomNavigationBarType.fixed,
					selectedFontSize: 12,
					unselectedFontSize: 12,
					onTap: onTappedBar,
					currentIndex: _currentIndex,
					items: [
						BottomNavigationBarItem(
							icon: new Icon(
								Icons.home_filled,
							),
							title: new Text("Home"),
						),
						BottomNavigationBarItem(
							icon: new Icon(Icons.my_library_books),
							title: new Text("Education"),
						),
						BottomNavigationBarItem(
							icon: new Icon(
								Icons.post_add_outlined,
							),
							title: new Text("Request"),
						),
						BottomNavigationBarItem(
							icon: Icon(
								Icons.account_circle_sharp,
							),
							title: Text("Profile"),
						)
					],
				),
			body: IndexedStack(
				index: _currentIndex,
				children: _children
			)
		);
	}

}