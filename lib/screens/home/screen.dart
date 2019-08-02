import 'dart:convert';

import 'package:aris_frontend/services/findtutor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:nice_button/nice_button.dart';
import 'package:aris_frontend/services/listTopics.dart';

class HomeScreen extends StatefulWidget{
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>{

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  loadTopics() {
    listTopics().then((List<Topic> topics) {
      List<String> topicStrings = [];
      Map<String, int> topicMap = {};
      for (Topic t in topics) {
        topicStrings.add(t.name);
        topicMap[t.name] = t.id;
      }
      setState(() {
        this.topics = topicStrings;
        this.topicMap = topicMap;
      });
    });
  }

  void initState() {
    super.initState();
    loadTopics();
  }

  String chosenCourse = "Fundamentals of Computing";
  String chosenTopic = "Select Topic";
  Topic chosenTopicObj;
  String tutorName;
  String tutorPhone;

  List<String> courses = ["Fundamentals of Computing"];
  List<String> topics = [];
  Map<String, int> topicMap;

  showCoursePicker(BuildContext context) {
    Picker picker = Picker(
      confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 18.0),
      cancelTextStyle: TextStyle(color: Colors.red, fontSize: 18.0),
      adapter: PickerDataAdapter<String>(pickerdata: courses),
      changeToFirst: true,
      title: Text("Select Course"),
      textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        setState(() {
          chosenCourse = picker.getSelectedValues()[0];
        });
      }
    );
    picker.show(_scaffoldKey.currentState);
  }

  showTopicPicker(BuildContext context) {
    Picker picker = Picker(
      confirmTextStyle: TextStyle(color: Colors.blue, fontSize: 18.0),
      cancelTextStyle: TextStyle(color: Colors.red, fontSize: 18.0),
      adapter: PickerDataAdapter<String>(pickerdata: topics),
      title: Text("Select Topic"),
      changeToFirst: true,
      textAlign: TextAlign.left,
      columnPadding: const EdgeInsets.all(8.0),
      onConfirm: (Picker picker, List value) {
        setState(() {
          chosenTopic = picker.getSelectedValues()[0];
        });
      }
    );
    picker.show(_scaffoldKey.currentState);
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Meet Your Tutor'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Session: ${chosenTopic}"),
              Text("Name: ${tutorName}"),
              Text("Phone: ${tutorPhone}"),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel Session', style: TextStyle(color: Colors.red)),
              onPressed: () {
                print("Pressed Cancel");
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Start Session', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                print("Pressed Log");
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Michael Erdenberger"),
              accountEmail: Text("merdenbe@nd.edu"),
              currentAccountPicture: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/defaultProfilePic.jpg'
                  )
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.card_giftcard),
              title: Text(
                'Redeem Coupons',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/coupons');
              },
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text(
                'Request Courses',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/course_request');
              },
            ),
            ListTile(
              leading: Icon(Icons.rate_review),
              title: Text(
                'Send Feedback',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/feedback');
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                'FAQ',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/faq');
              },
            ),
            Divider(),
            Padding(padding: EdgeInsets.only(top: 375.0)),
            ListTile(
              leading: Icon(Icons.keyboard_return),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 18.0),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        )
      ),
      appBar: AppBar(
        title: Text(""),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 100.0)),
              Text(
                'Find a Tutor',
                style: TextStyle(color: Color(0xff390D58), fontSize: 36.0)
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Text(
                'Select Course',
                style: TextStyle(color: Color(0xff390D58), fontSize: 24.0)
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              SizedBox(
                width: 400,
                height: 50,
                child: RaisedButton(
                  child: Text(chosenCourse, style: TextStyle(color: Colors.black, fontSize: 18.0)),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xff390D58)),
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  onPressed: () {
                    showCoursePicker(context);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30.0)),
              Text(
                'Select Topic',
                style: TextStyle(color: Color(0xff390D58), fontSize: 24.0)
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              SizedBox(
                width: 400,
                height: 50,
                child: RaisedButton(
                  child: Text(chosenTopic, style: TextStyle(color: Colors.black, fontSize: 18.0)),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xff390D58)),
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                  onPressed: () {
                    showTopicPicker(context);
                  },
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 50.0)),
              Align(
                alignment: Alignment.center,
                child: NiceButton(
                  width: 300,
                  elevation: 8,
                  radius: 52,
                  padding: const EdgeInsets.all(10),
                  text: "Find Tutor",
                  gradientColors: [Color(0xff390D58), Colors.purpleAccent],
                  onPressed: () {
                    if (chosenTopic == "Select Topic") {
                      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select a topic.'), backgroundColor: Colors.red,));
                    } else {
                      int topic_id = topicMap[chosenTopic];
                      var body = json.encode({
                        'account_id': 1,
                        'topic_id': topic_id
                      });
                      findTutor(body).then((TutorInfo t) {
                        setState(() {
                          tutorName = "${t.firstName} ${t.lastName}";
                          tutorPhone = t.phoneNumber;
                        });
                        if (t.firstName == "Error") {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('No tutors available at this time.'), backgroundColor: Colors.red,));
                          return;
                        }
                        _displayDialog(context);
                      });
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}