import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SelectionModal extends StatefulWidget {
  @override
  _SelectionModalState createState() => _SelectionModalState();

  final List dataSource;
  final List values;
  final bool filterable;
  final String textField;
  final String valueField;
  final String title;
  final int maxItems;

  SelectionModal(
      {this.filterable,
      this.dataSource,
      this.title = 'Please select one or more option(s)',
      this.values,
      this.textField,
      this.valueField,
      this.maxItems})
      : super();
}

class _SelectionModalState extends State<SelectionModal> {
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;

  List _localDataSourceWithState = [];
  List _searchresult = [];

  _SelectionModalState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.dataSource.forEach((item) {
      var newItem = {
        'value': item[widget.valueField],
        'text': item[widget.textField],
        'checked': widget.values.contains(item[widget.valueField])
      };
      _localDataSourceWithState.add(newItem);
    });

    _searchresult = List.from(_localDataSourceWithState);
    _isSearching = false;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Container(),
      elevation: 0.0,
      title: Text(widget.title, style: TextStyle(fontSize: 16.0)),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.close,
            size: 26.0,
          ),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          widget.filterable ? _buildSearchText() : new SizedBox(),
          Expanded(
            child: _optionsList(),
          ),
          _currentlySelectedOptions(),
          Container(
            color: Colors.grey.shade600,
            child: ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text('Cancel'),
                      icon: Icon(
                        Icons.clear,
                        size: 20.0,
                      ),
                      color: Colors.grey.shade100,
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                    ),
                  ),
                  ButtonTheme(
                    height: 50.0,
                    child: RaisedButton.icon(
                      label: Text('Save'),
                      icon: Icon(
                        Icons.save,
                        size: 20.0,
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () {
                        var selectedValuesObjectList = _localDataSourceWithState
                            .where((item) => item['checked'])
                            .toList();

                        if (widget.maxItems < selectedValuesObjectList.length) {
                          Fluttertoast.showToast(
                              msg: "Please select only "+widget.maxItems.toString()+" value(s).",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 4,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 18.0);
                        } else {
                          var selectedValues = [];
                          selectedValuesObjectList.forEach((item) {
                            selectedValues.add(item['value']);
                          });
                          Navigator.pop(context, selectedValues);
                        }
                      },
                    ),
                  )
                ]),
          )
        ],
      ),
    );
  }

  Widget _currentlySelectedOptions() {
    List<Widget> selectedOptions = [];

    var selectedValuesObjectList =
        _localDataSourceWithState.where((item) => item['checked']).toList();
    var selectedValues = [];
    selectedValuesObjectList.forEach((item) {
      selectedValues.add(item['value']);
    });
    selectedValues.forEach((item) {
      var existingItem = _localDataSourceWithState
          .singleWhere((itm) => itm['value'] == item, orElse: () => null);
      selectedOptions.add(Chip(
        label: new Container(
          constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 80.0),
          child: Text(existingItem['text'], overflow: TextOverflow.ellipsis),
        ),
        deleteButtonTooltipMessage: 'Tap to delete this item',
        deleteIcon: Icon(Icons.cancel),
        deleteIconColor: Colors.grey,
        onDeleted: () {
          existingItem['checked'] = false;
          setState(() {});
        },
      ));
    });
    return selectedOptions.length > 0
        ? Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey.shade400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Text(
                  'Currently selected ${selectedOptions.length} items (tap to remove)', // use languageService here
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                ConstrainedBox(
                    constraints: new BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 8,
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 0.4, // gap between lines
                        alignment: WrapAlignment.start,
                        children: selectedOptions,
                      )),
                    )),
              ],
            ),
          )
        : new Container();
  }

  ListView _optionsList() {
    List<Widget> options = [];
    _searchresult.forEach((item) {
      options.add(ListTile(
          title: Text(item['text'] ?? ''),
          leading: Transform.scale(
            child: Icon(
                item['checked']
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Theme.of(context).primaryColor),
            scale: 1.5,
          ),
          onTap: () {
            item['checked'] = !item['checked'];
            setState(() {});
          }));
      options.add(new Divider(height: 1.0));
    });
    return ListView(children: options);
  }

  Widget _buildSearchText() {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: TextField(
              controller: _controller,
              keyboardAppearance: Brightness.light,
              onChanged: searchOperation,
              decoration: new InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(6.0),
                    ),
                  ),
                  filled: true,
                  hintText: "Search...",
                  fillColor: Colors.white,
                  suffix: SizedBox(
                      height: 25.0,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          searchOperation('');
                        },
                        padding: EdgeInsets.all(0.0),
                        tooltip: 'Clear',
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  void searchOperation(String searchText) {
    _searchresult.clear();
    if (_isSearching != null &&
        searchText != null &&
        searchText.toString().trim() != '') {
      for (int i = 0; i < _localDataSourceWithState.length; i++) {
        String data =
            '${_localDataSourceWithState[i]['value']} ${_localDataSourceWithState[i]['text']}';
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchresult.add(_localDataSourceWithState[i]);
        }
      }
    } else {
      _searchresult = List.from(_localDataSourceWithState);
    }
  }
}
