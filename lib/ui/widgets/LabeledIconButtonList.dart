import 'package:flutter/material.dart';
import 'package:partnership/ui/widgets/LabeledIconButton.dart';

class LabeledIconButtonList extends StatelessWidget {
  final List<LabeledIconButton> _childs;
  final bool _forceFullWidth;
  LabeledIconButtonList(
      {@required List<LabeledIconButton> childs, bool forceFullWidth = false})
      : _childs = childs,
        _forceFullWidth = forceFullWidth {}
  Widget _buildColumnElem(List<Widget> rowContent, Function function) {
    Widget buttonContent = Row(children:rowContent, mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max,);
    Widget result = MaterialButton(onPressed: function, child: buttonContent, );
    return (result);
  }
  Column _buildColumn() {
    List<Widget> rows = List<Widget>();
    for (LabeledIconButton elem in _childs)
      rows.add(_buildColumnElem(elem.buildRowContent(), elem.onPressed));
    Column result;
    result = (_forceFullWidth == true)
        ? Column(
            mainAxisSize: MainAxisSize.max,
            children: rows,
          )
        : Column(
            children: rows,
          );
    return (result);
  }

  @override
  Widget build(BuildContext context) {
    Column column = _buildColumn();
    Container container = Container(
      child: column,
    );
    return (container);
  }
}
