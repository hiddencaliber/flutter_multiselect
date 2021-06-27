import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        //brightness: Brightness.dark,
      ),
      home: MyHomePage(title: 'Flutter Demo - Multiselect'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MultiSelect(
                //--------customization selection modal-----------
                buttonBarColor: Colors.red,
                cancelButtonText: "Exit",
                titleText: "Custom Title",
                checkBoxColor: Colors.black,
                selectedOptionsInfoText: "Selected custom text (tap to remove)",
                selectedOptionsBoxColor: Colors.green,
                autovalidateMode: AutovalidateMode.always,
                maxLength: 5, // optional
                //--------end customization selection modal------------
                validator: (dynamic value) {
                  if (value == null) {
                    return 'Please select one or more option(s)';
                  }
                  return null;
                },
                errorText: 'Please select one or more option(s)',
                dataSource: [
                  {"name": "Afghanistan", "code": "AF"},
                  {"name": "Åland Islands", "code": "AX"},
                  {"name": "Albania", "code": "AL"},
                ],
                textField: 'name',
                valueField: 'code',
                filterable: true,
                required: true,
                onSaved: (value) {
                  print('The selected values are $value');
                },
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
