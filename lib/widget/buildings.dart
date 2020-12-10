import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuildingsPage extends StatefulWidget {
  @override
  _BuildingsPageState createState() => _BuildingsPageState();
}

class _BuildingsPageState extends State<BuildingsPage> {
  String _projectName = '';
  String _currentLevel = '';

  List<Widget> _buildings = [];
  int _currentIndex = 0;

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _loadProjectName();
  }

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return _loading();
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(_projectName)
          .doc('levels')
          .collection('levels')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return _loading();

        return _buildBody(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildBody(context, docs) {
    _initBuildings(docs);
    return Scaffold(
      appBar: AppBar(
        title: Text(_buildings[_currentIndex].toString()),
      ),
      drawer: Drawer(
        child: ListView.builder(
            itemCount: _buildings.length,
            itemBuilder: (context, index) => ListTile(
                  title: Text(_buildings[index].toString()),
                  onTap: () => _selectLevel(index),
                )),
      ),
      body: _buildings[_currentIndex],
    );
  }

  void _initBuildings(List<DocumentSnapshot> docs) {
    _buildings = docs.map((data) => LevelWidget.fromSnapshot(data)).toList();
  }

  void _loadProjectName() async {
    this._projectName =
        await DefaultAssetBundle.of(context).loadString('res/creditlines.data');
    _initialized = true;
  }

  void _selectLevel(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class LevelWidget extends StatelessWidget {
  final String _name;
  final String _image;
  final DocumentReference reference;
  final Uint8List _bytes;

  LevelWidget.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['image'] != null),
        _name = map['name'],
        _image = map['image'],
        _bytes = base64Decode(map['image']);

  LevelWidget.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  Widget build(BuildContext context) {
    return Image.memory(_bytes);
  }

  String get image => _image;

  String get name => _name;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return name;
  }
}
