import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:task/pages/add_event_page.dart';
import 'package:task/pages/add_task_page.dart';
import 'package:task/pages/event_page.dart';
import 'package:task/pages/task_page.dart';
import 'package:task/providers/events.dart';
import 'package:task/providers/tasks.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Tasks()),
        ChangeNotifierProvider(create: (context) => Events()),
      ],
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'To Do',
        home:   SplashScreen(
          seconds: 14,
          navigateAfterSeconds: MyHomePage(),
          image: Image.network('https://blog.doist.com/wp-content/uploads/2015/09/image_detail@2x1.png'),
          photoSize: 100,
          loaderColor: Colors.white,
        ),
       
        theme: ThemeData(
        primarySwatch: Colors.red,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
String formatter = DateFormat('d').format(DateTime.now());
 String f = DateFormat('EEEE').format(DateTime.now());
  PageController _pageController = PageController();
  double currentPage =0;


  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
setState(() {
  currentPage = _pageController.page;
});
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 35,
            color: Theme.of(context).accentColor,
          ),
          Positioned(
            right: 0,
            child: Text(
              formatter,
              style: TextStyle(
                fontSize: 200,
                color: Color(0x10000000),
              ),
            ),
          ),
          _mainContent(context)
        ],
      ),
       floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
          focusColor: Colors.white,
          onPressed: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return Dialog(
                    child: currentPage == 0 ? AddTaskPage() : AddEventPage(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.settings),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                        child: Container(
                          height: 400,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'What do you want to remember?'),
                                ),
                                SizedBox(
                                  width: 320.0,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: const Color(0xFF1BC0C5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
      
      
    );
  }

  Widget _mainContent(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            f,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: _button(context),
        ),
        Expanded(child: PageView(
          controller: _pageController,
          children: <Widget>[
            TaskPage(),
            EventPage()
        ])),
      ],
    );
  }

Widget _button(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MaterialButton(
          padding: const EdgeInsets.all(14.0),
          child: Center(
              child: Text(
            'Tasks',
          )),
          color:
              currentPage < 0.5 ? Theme.of(context).accentColor : Colors.white,
          textColor:
              currentPage < 0.5 ? Colors.white : Theme.of(context).accentColor,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: () {
             _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
        ),
        SizedBox(
          width: 32,
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(14.0),
          child: Text(
            'Events',
          ),
          color:
              currentPage > 0.5 ? Theme.of(context).accentColor : Colors.white,
          textColor:
              currentPage > 0.5 ? Colors.white : Theme.of(context).accentColor,
       
          onPressed: () {
            _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.bounceInOut);
          },
        ),
      ],
    ),
  );
}
}
