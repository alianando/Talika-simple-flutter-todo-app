import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  bool isSwitchedAbout;

  AboutPage(this.isSwitchedAbout);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            (widget.isSwitchedAbout == false) ? Colors.white70 : Colors.black54,
        title: Text(
          'About',
          style: TextStyle(
            color:
                (widget.isSwitchedAbout == false) ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: Container(
        color:
            (widget.isSwitchedAbout == false) ? Colors.white : Colors.black87,
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 25.0, left: 10.0, right: 10.0),
              child: Text(
                '   This is a simple note taking app with a simple and beautiful design.',
                style: TextStyle(
                  fontSize: 24.0,
                  color: (widget.isSwitchedAbout == false)
                      ? Colors.black54
                      : Colors.white70,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(color: Colors.green, border: Border.all()),
              child: Image.asset('assets/color.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                ' A specific color of a rounded icon can be added in every task.'
                ' The different colored icon can be used in many ways. '
                'For example the different colors can indicate the importance '
                'of the note or task. Red icon can indicate the most important'
                ' note or task, Blue icon can indicate less important notes or task and so on.',
                style: TextStyle(
                  fontSize: 24.0,
                  color: (widget.isSwitchedAbout == false)
                      ? Colors.black54
                      : Colors.white70,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Image.asset('assets/done.jpg'),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Upon completing a task, the user can swipe right to left to dismiss a note or task',
                style: TextStyle(
                  fontSize: 24.0,
                  color: (widget.isSwitchedAbout == false)
                      ? Colors.black54
                      : Colors.white70,
                ),
              ),
            ),
            Divider(
              color: (widget.isSwitchedAbout == false)
                  ? Colors.black54
                  : Colors.white70,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              child: Center(
                child: Text(
                  'This app is developed by Ali Anando.',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: (widget.isSwitchedAbout == false)
                        ? Colors.black54
                        : Colors.white70,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Contact the developer, Email:',
                style: TextStyle(
                  fontSize: 20.0,
                  color: (widget.isSwitchedAbout == false)
                      ? Colors.black54
                      : Colors.white70,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Center(
                child: Text(
                  'alianando44@gmail.com',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: (widget.isSwitchedAbout == false)
                        ? Colors.black54
                        : Colors.white70,
                  ),
                ),
              ),
            ),
            Divider(
              color: (widget.isSwitchedAbout == false)
                  ? Colors.black54
                  : Colors.white70,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}
