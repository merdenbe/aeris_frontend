import 'package:flutter/material.dart';

import 'package:aris_frontend/services/getQuestions.dart';

class FAQScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return FAQScreenState();
  }
}

class FAQScreenState extends State<FAQScreen>{

  List<Map<String, String>> questions = [];

  loadQuestions() {
    getQuestions().then((List<Map<String, String>> questions) {
      setState(() {
        this.questions = questions;
      });
    });
  }

  void initState() {
    super.initState();
    loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView.builder(
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(questions[index]["content"]),
                subtitle: Text(questions[index]["answer"]),
              )
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        icon: Icon(Icons.add),
        label: Text('Ask New Question'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        child: Padding(padding: EdgeInsets.only(top: 35.0)),
      )
    );
  }
}