import 'package:flutter/material.dart';
import 'package:sp1_midterm_exam/screens/starwars_list.dart';
import 'package:sp1_midterm_exam/screens/page2.dart';
import 'package:sp1_midterm_exam/screens/page3.dart';
import 'package:sp1_midterm_exam/screens/page4.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _pageWidget = <Widget>[
    StarwarsList(),
    Page2(),
    Page3(),
    Page4(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'About',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Profile',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Contact',
    ),
  ];
  void _onTapBottomAppBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(left: 0),
            child: Text('SP1 Midterm Exam',
                style: TextStyle(color: Colors.black, fontSize: 16)),
          ),
          brightness: Brightness.light, //centerTitle: true,
          // centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh_rounded),
              onPressed: () {},
            )
          ],
        ),
        body: _pageWidget.elementAt(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: _menuBar,
          currentIndex: _currentIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey,
          onTap: _onTapBottomAppBar,
        ),
      ),
    );
  }
}
