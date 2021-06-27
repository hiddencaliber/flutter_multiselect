import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

import 'cities.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _rebuilder,
        builder: (context, int value, child) {
          return MaterialApp(
            key: ValueKey(value),
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            themeMode: value.isOdd ? ThemeMode.light : ThemeMode.dark,
            theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
            darkTheme: ThemeData(primarySwatch: Colors.red, brightness: Brightness.dark),
            home: MyHomePage(title: 'Flutter Demo - Multiselect'),
          );
        });
  }
}

final _RebuildApp _rebuilder = _RebuildApp();

void rebuildApp() => _rebuilder.execute();

class _RebuildApp extends ValueNotifier<int> {
  _RebuildApp() : super(1);

  void execute() => value = value + 1;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          ElevatedButton(
              onPressed: () => rebuildApp(),
              child: _rebuilder.value.isOdd ? Text('Switch to Dark theme') : Text('Switch to Light theme'))
        ],
      ),
      body: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MultiSelect(
                  autovalidateMode: AutovalidateMode.always,
                  initialValue: ['IN', 'US'],
                  titleText: 'Country of Residence',
                  maxLength: 5, // optional
                  validator: (dynamic value) {
                    return value == null ? 'Please select one or more option(s)' : null;
                  },
                  errorText: 'Please select one or more option(s)',
                  dataSource: cities,
                  textField: 'name',
                  valueField: 'code',
                  filterable: true,
                  required: true,
                  onSaved: (value) {
                    print('The saved values are $value');
                  },
                  change: (value) {
                    print('The selected values are $value');
                  },
                  selectIcon: Icons.arrow_drop_down_circle,
                  saveButtonColor: Theme.of(context).primaryColor,
                  checkBoxColor: Theme.of(context).primaryColorDark,
                  cancelButtonColor: Theme.of(context).primaryColorLight,
                  responsiveDialogSize: Size(600, 800),
                ),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  _onFormSaved();
                }),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    )
    );
  }

  void _onFormSaved() {
    final FormState? form = _formKey.currentState;
    form?.save();
  }
}
