import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function  _search;
  final dynamic   _defaultValue;
  final String    _emptyFieldLabel;
  final String    _fieldName;
  final Function  _select;
  final Function  _validate;
  dynamic         _selected;
  SearchBar({
      @required Function  onQuery,
      @required dynamic   defaultValue,
      @required Function  select,
      @required Function  validate,
      String              emptyFieldLabel = "",
      String              fieldName =       "",
    }) :
    _search = onQuery,
    _defaultValue = defaultValue,
    _emptyFieldLabel = emptyFieldLabel,
    _fieldName =fieldName,
    _select = select,
    _validate = validate;
  void validate() {

  }
  Future<dynamic> _getResults(String value) {
    return (_search(value));
  }
  @override
  _SearchBarState createState() {
    return _SearchBarState(
      value:_defaultValue,
      emptyFieldLabel: _emptyFieldLabel,
      select:_select,
      validate: () => this.validate(),
    );
  }
}

class _SearchBarState extends State<SearchBar> {
  final String  _emptyFieldLabel;
  final String  _title;
  _SearchBarState({
    @required dynamic value,
    @required String title,
    @required String emptyFieldLabel,
    @required Function select,
    @required Function validate,
  }) :
  _emptyFieldLabel = emptyFieldLabel,
  _title = title;
  Widget _buildFormChild() {
    InputDecoration decoration = InputDecoration(
      hintText: _emptyFieldLabel,
      labelText: _title,
    );
    TextField result = TextField(decoration: decoration);
    return (result);
  }
  Form  _buildForm() {
    Widget child = _buildFormChild();
    Function onWillPop;
    Form result = Form(child: child, onWillPop: onWillPop);
    return (result);
  }
  @override
  Widget build(BuildContext context) {
    Form result = _buildForm();
    return result;
  }
}