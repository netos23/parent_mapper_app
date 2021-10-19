import 'package:flutter/material.dart';
import 'package:parent_mapper_app/core/node.dart';
import 'package:parent_mapper_app/widget/painter.dart';

class SearchPage extends StatefulWidget {
  var _projectName;

  SearchPage(this._projectName);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Node> points = [Node(100, 100, 'sdsa',2,'dsf'), Node(200, 200, 'node',2,'dsf')];

  @override
  Widget build(BuildContext context) {
    SizeUtil.size = MediaQuery.of(context).size;
    return Column(
      children: [
        TextField(),
        TextField(),
        Container(
            width: 200,
            height: 400,
            color: Colors.deepPurple,
            child: CustomPaint(
              painter: OpenPainter(points, context, 1000, 1000),
            )
        ),
      ],
    ) ;
  }
}
