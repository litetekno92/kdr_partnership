import 'package:flutter/material.dart';
import '../utils/Routes.dart';
import '../viewmodel/AViewModelFactory.dart';
import '../viewmodel/ProjectBrowsingPageViewModel.dart';
import '../ui/widgets/ProjectScrollList.dart';
import '../ui/widgets/SearchBar.dart';

class ProjectBrowsingPage extends StatefulWidget {
  @override
  ProjectBrowsingPageState createState() => ProjectBrowsingPageState();
}

class ProjectBrowsingPageState extends State<ProjectBrowsingPage> {
  IRoutes      _routing = Routes();
  List<ProjectScrollListItemData> _projectList = List();
  ProjectBrowsingPageViewModel get viewModel =>
      AViewModelFactory.register[_routing.projectBrowsingPage];
  @override
  void initState(){
    super.initState();
    this.viewModel.getProjectList(query:"", onUpdate:(value) => this._updateProjectList(value));
  }
  void _updateProjectList(List<ProjectScrollListItemData> list) {
    this.setState(()
    {
      if (!mounted)
        return ;
      this._projectList = list;
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double listHeight = screenHeight * 9 / 10;
    double searchBarHeight = screenHeight * 1 / 10;

    SearchBar searchBar = SearchBar(onQuery: this.viewModel.searchTag,);
    ProjectScrollList list = ProjectScrollList.fromDataList(this._projectList, height: listHeight);
    
    return Scaffold( 
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
            child: Container(
              child: Column(children: <Widget>[searchBar, list],),
            )
        )
    );
  }
}
