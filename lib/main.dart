import 'package:flutter/material.dart';
import 'desert_page.dart' as desert;
import 'seafood_page.dart' as seafood;

void main() => runApp(MaterialApp(
  title: "Submission 03",
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Submission 03"),
        ),

        body: TabBarView(
            controller: tabController,
            children: <Widget>[
              seafood.SeafoodPage(),
              desert.DesertPage(),
            ]),

        bottomNavigationBar: SizedBox(
          height: 58,
          child: Material(
            color: Colors.blueGrey[300],
            child: TabBar(
              controller: tabController,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.fastfood)),
                Tab(icon: Icon(Icons.cake)),
              ],
            ),
          ),
        )
    );
  }
}

