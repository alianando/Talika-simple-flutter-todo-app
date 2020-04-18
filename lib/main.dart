import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'databasehelper.dart';
import 'about.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  var _scaffoldkey = new GlobalKey<ScaffoldState>();
  final DbTaskManager dbmanager = new DbTaskManager();

  bool isSwitched = false;

  TextEditingController controlleraaaa = new TextEditingController();

  Task task;
  List<Task> taskList; //main list

  var _color = Colors.grey;

  Widget _threeItemPopup() => PopupMenuButton(
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Icon(Icons.trip_origin, color: Colors.grey),
          ),
          PopupMenuItem(
            value: 2,
            child: Icon(Icons.trip_origin, color: Colors.blue),
          ),
          PopupMenuItem(
            value: 3,
            child: Icon(Icons.trip_origin, color: Colors.red),
          ),
        ],
        initialValue: 1,
        onCanceled: () {},
        onSelected: (value) {
          setState(
            () {
              switch (value) {
                case 1:
                  {
                    _color = Colors.grey;
                    break;
                  }
                case 2:
                  {
                    _color = Colors.blue;
                    break;
                  }
                case 3:
                  {
                    _color = Colors.red;
                    break;
                  }
              }
            },
          );
        },
        icon: Icon(
          Icons.trip_origin,
          color: _color,
        ),
      );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'ToDay',
          style: TextStyle(
            color: (isSwitched == false) ? Colors.black54 : Colors.white,
          ),
        ),
        elevation: 1.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            color: (isSwitched == false) ? Colors.black54 : Colors.white,
            onPressed: () {
              _scaffoldkey.currentState.openEndDrawer();
            },
          )
        ],
        backgroundColor: (isSwitched == false) ? Colors.white : Colors.black54,
      ),
      body: Container(
        color: (isSwitched == false) ? Colors.white : Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 17.0, left: 10.0),
                child: FutureBuilder(
                  future: dbmanager.getTaskList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      taskList = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: taskList == null ? 0 : taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Task tk = taskList[index];
                          return Dismissible(
                            onDismissed: (DismissDirection direction) {
                              dbmanager.deleteTask(tk.id);
                              setState(
                                () {
                                  taskList.removeAt(index);
                                },
                              );
                            },
                            secondaryBackground: Container(
                              width: 150.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Icon(
                                    Icons.check_circle_outline,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: 10.0,
                                  ),
                                  Text(
                                    'DONE',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Container(
                                    width: 50.0,
                                  )
                                ],
                              ),
                              color: Colors.lightGreen,
                            ),
                            background: Container(),
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            child: Container(
                              width: width * 0.6,
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(
                                      Icons.trip_origin,
                                      color: (tk.color ==
                                              'MaterialColor(primary value: Color(0xff9e9e9e))')
                                          ? Colors.grey
                                          : (tk.color ==
                                                  'MaterialColor(primary value: Color(0xff2196f3))')
                                              ? Colors.blue
                                              : Colors.red,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          '${tk.name}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: (isSwitched == false)
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return new CircularProgressIndicator();
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              color: (isSwitched == false) ? Colors.black12 : Colors.black45,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    child: _threeItemPopup(),
                    width: 60.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 40.0,
                        child: Theme(
                          data: ThemeData(
                              primaryColor: Colors.grey,
                              primaryColorDark: Colors.red),
                          child: new TextField(
                            onSubmitted: (String sa) {
                              setState(
                                () {
                                  _submitTask(context);
                                  controlleraaaa.clear();
                                  _color = Colors.grey;
                                },
                              );
                            },
                            controller: controlleraaaa,
                            textCapitalization: TextCapitalization.sentences,
                            style: TextStyle(
                              color: (isSwitched == false)
                                  ? Colors.black54
                                  : Colors.white38,
                            ),
                            decoration: InputDecoration(
                              hintText: ('What we have to do Today'),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: (isSwitched == false)
                                    ? Colors.black54
                                    : Colors.white38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60.0,
                    child: FlatButton(
                      onPressed: () {
                        setState(
                          () {
                            _submitTask(context);
                            controlleraaaa.clear();
                            _color = Colors.grey;
                          },
                        );
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: (isSwitched == false)
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: (isSwitched == false) ? Colors.white : Colors.black87,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 95.0,
                child: DrawerHeader(
                  child: Text(
                    'Extras',
                    style: TextStyle(
                      color:
                          (isSwitched == false) ? Colors.black54 : Colors.grey,
                      fontSize: 22.0,
                    ),
                  ),
                  decoration: BoxDecoration(),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: width * .48,
                      child: Text(
                        'Night mode',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: (isSwitched == false)
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(
                          () {
                            isSwitched = value;
                          },
                        );
                      },
                      activeColor: Colors.black,
                      activeTrackColor: Colors.grey,
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                title: Text(
                  'About',
                  style: TextStyle(
                    color: (isSwitched == false) ? Colors.black : Colors.grey,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutPage(isSwitched),
                    ),
                  );
                },
              ),
              Container(
                height: height * .715,
              ),
              Container(
                alignment: FractionalOffset.bottomCenter,
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: (isSwitched == false) ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitTask(BuildContext context) {
    Task tk = new Task(name: controlleraaaa.text, color: '$_color');
    dbmanager.insertTask(tk);
  }
}
