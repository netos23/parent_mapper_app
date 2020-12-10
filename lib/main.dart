import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parent_mapper_app/widget/buildings.dart';
import 'package:parent_mapper_app/widget/search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  List<Widget> _pages = <StatefulWidget>[
      BuildingsPage(),
      SearchPage()
  ];

  int _selectedIndex = 0;
  Widget _currentWidget;

  bool _initialized = false;

  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _currentWidget = _pages[_selectedIndex];
    initializeFlutterFire();
  }

  @override
  Widget build(BuildContext context) {
    if(_error) {
      return Text('errrrrrror!!!!! restart me~!');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return LinearProgressIndicator();
    }

    return Scaffold(
      body: _currentWidget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.deepPurple,
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
              backgroundColor: Colors.purple,
              label: "Buildings",
              icon: Icon(
                Icons.map,
              )
          ),

          BottomNavigationBarItem(
              backgroundColor: Colors.purple,
              icon: Icon(Icons.search),
              label: 'Search'
          ),

        ],

        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onTouch,
      ),
    );
  }

  void _onTouch(int value) {
    setState(() {
      _selectedIndex = value;
      _currentWidget = _pages[_selectedIndex];
    });
  }
}
