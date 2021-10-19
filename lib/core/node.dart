class Node {
  final double _x;
  final double _y;
  final String _name;
  final int _type;
  final String parent;

  const Node(this._x, this._y, this._name, this._type, this.parent);

  Node.fromMap(Map<String, dynamic> node)
      : this(node['x'], node['y'], node['name'], node['type'], node['parent']);

  String get name => _name;

  double get y => _y;

  double get x => _x;
}

class MultiNode extends Node {
  MultiNode(double x, double y, String name, int type, String parent)
      : super(x, y, name, type, parent);
}
