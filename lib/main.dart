import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:vibrate/vibrate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
          Expanded(
              child: SwipeDetector(
                  onSwipeLeft: () {
                    setSelectedCount(0);
                  },
                  child: IntrinsicHeight(
                      child: Center(
                          child: Text(
                    selectedCount.toString(),
                    style: TextStyle(color: Colors.blue, fontSize: 300),
                  ))))),
          Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        createBtn(1),
                        createBtn(2),
                        createBtn(3)
                      ])),
              Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        createBtn(5),
                        createBtn(8),
                        createBtn(13)
                      ])),
            ],
          )
        ]));
  }

  void setSelectedCount(int count) {
    setState(() {
      selectedCount = count;
    });
  }

  Widget createBtn(int count) {
    return SizedBox(
        width: 80,
        height: 80,
        child: RaisedButton(
          color: Colors.blue,
          shape: CircleBorder(),
          onPressed: () {
            vibrate();
            setSelectedCount(count);
          },
          child: Text(
            count.toString(),
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ));
  }

  void vibrate() async {
    bool canVibrate = await Vibrate.canVibrate;
    canVibrate ? Vibrate.feedback(FeedbackType.medium) : null;
  }
}
