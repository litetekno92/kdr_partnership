import 'package:flutter/material.dart';

class LabeledIconButton extends StatelessWidget {
  Function _onPressed;
  String _text;
  Icon _icon;
  TextAlign _align;
  String _toolTip;
  bool _fullWidth;
  double _iconSize;
  String get text => _text;
  Function get onPressed => _onPressed;
  LabeledIconButton(
      {@required Function onPressed,
      @required String text,
      @required Icon icon,
      TextAlign align = TextAlign.left,
      String toolTip,
      double iconSize = 30.0,
      bool fullWidth = false}) {
    _onPressed = onPressed;
    _text = text;
    _icon = icon;
    _align = align;
    _toolTip = toolTip;
    _iconSize = iconSize;
    _fullWidth = fullWidth;
  }
  Row _buildRow(List<Widget> rowContent) {
    FlatButton button = FlatButton(onPressed: _onPressed, child: Row(children:rowContent));
    if (_fullWidth)
      return Row(mainAxisSize:MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceAround, children: [button],);
    else
      return Row(children: [button],);
  }
  Widget _buildIcon() {
    return IconButton(
        icon: _icon,
        iconSize: _iconSize,
        tooltip: _toolTip,
        onPressed: _onPressed);
  }
  Widget _buildText() {
    return Text(_text);
  }
  List<Widget> buildRowContent() {
    List<Widget> result = List<Widget>();
    Widget icon = _buildIcon();
    Widget text = _buildText();
    if (_align == TextAlign.right)
      result.addAll([icon, text]);
    else
      result.addAll([text, icon]);
    return (result);
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> content = buildRowContent();
    Row row = _buildRow(content);
    return (Padding(
      padding: EdgeInsets.all(8.0),
      child: row,
    ));
  }
}
