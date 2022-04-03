import 'package:oldcode/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:oldcode/app/pages/login_page.dart';
import 'package:oldcode/app/pages/login_page.dart';

class AuthFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
	    title: 'Social App',
      theme: new ThemeData(
        primaryColor: Colors.green.shade500,
        textSelectionColor: Colors.green.shade500,
        buttonColor: Colors.green.shade500,
	      accentColor: Colors.green.shade500,
	      bottomAppBarColor: Colors.white
      ),
      home: new LoginPage(),
	    routes: {
      	HomePage.routeName: (BuildContext context) => new HomePage()
	    },
    );
  }
}