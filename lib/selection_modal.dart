import 'package:flutter/material.dart';

class SelectionModal extends StatefulWidget {
  @override
  _SelectionModalState createState() => _SelectionModalState();

  final List dataSource;
  final List values;
  final bool filterable;
  final String textField;
  final String valueField;
  final String title;
  final int? maxLength;
  final String? maxLengthText;
  final Color? buttonBarColor;
  final String? cancelButtonText;
  final IconData? cancelButtonIcon;
  final Color? cancelButtonColor;
  final Color? cancelButtonTextColor;
  final String? saveButtonText;
  final IconData? saveButtonIcon;
  final Color? saveButtonColor;
  final Color? saveButtonTextColor;
  final String? clearButtonText;
  final IconData? clearButtonIcon;
  final Color? clearButtonColor;
  final Color? clearButtonTextColor;
  final String? deleteButtonTooltipText;
  final IconData? deleteIcon;
  final Color? deleteIconColor;
  final Color? selectedOptionsBoxColor;
  final String? selectedOptionsInfoText;
  final Color? selectedOptionsInfoTextColor;
  final IconData? checkedIcon;
  final IconData? uncheckedIcon;
  final Color? checkBoxColor;
  final Color? searchBoxColor;
  final String? searchBoxHintText;
  final Color? searchBoxFillColor;
  final Color? searchBoxTextColor;
  final IconData? searchBoxIcon;
  final String? searchBoxToolTipText;
  SelectionModal(
      {this.filterable = true,
      this.dataSource = const [],
      this.title = 'Please select one or more option(s)',
      this.values = const [],
      this.textField = 'text',
      this.valueField = 'value',
      this.maxLength,
      this.maxLengthText,
      this.buttonBarColor,
      this.cancelButtonText,
      this.cancelButtonIcon,
      this.cancelButtonColor,
      this.cancelButtonTextColor,
      this.saveButtonText,
      this.saveButtonIcon,
      this.saveButtonColor,
      this.saveButtonTextColor,
      this.clearButtonText,
      this.clearButtonIcon,
      this.clearButtonColor,
      this.clearButtonTextColor,
      this.deleteButtonTooltipText,
      this.deleteIcon,
      this.deleteIconColor,
      this.selectedOptionsBoxColor,
      this.selectedOptionsInfoText,
      this.selectedOptionsInfoTextColor,
      this.checkedIcon,
      this.uncheckedIcon,
      this.checkBoxColor,
      this.searchBoxColor,
      this.searchBoxHintText,
      this.searchBoxFillColor,
      this.searchBoxTextColor,
      this.searchBoxIcon,
      this.searchBoxToolTipText})
      : super();
}

class _SelectionModalState extends State<SelectionModal> {
  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  bool _isSearching = false;

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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Container(),
      elevation: 0.0,
      title: Center(child: Text(widget.title, style: TextStyle(fontSize: 16.0))),
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
          widget.filterable ? _buildSearchText() : SizedBox(),
          Expanded(
            child: _optionsList(),
          ),
          _currentlySelectedOptions(),
          Container(
            color: widget.buttonBarColor ?? Colors.grey.shade600,
            child:
                ButtonBar(alignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: <Widget>[
              ButtonTheme(
                height: 50.0,
                child: ElevatedButton.icon(
                  label: Text(widget.cancelButtonText ?? 'Cancel'),
                  icon: Icon(
                    widget.cancelButtonIcon ?? Icons.clear,
                    size: 20.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: widget.cancelButtonColor ?? Colors.grey.shade100,
                      onPrimary: widget.cancelButtonTextColor ?? Colors.black87),
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                ),
              ),
              ButtonTheme(
                height: 50.0,
                child: ElevatedButton.icon(
                  label: Text(widget.clearButtonText ?? 'Clear All'),
                  icon: Icon(
                    widget.clearButtonIcon ?? Icons.clear_all,
                    size: 20.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: widget.clearButtonColor ?? Colors.black,
                      onPrimary: widget.clearButtonTextColor ?? Colors.white),
                  onPressed: () {
                    _clearSelection();
                  },
                ),
              ),
              ButtonTheme(
                height: 50.0,
                child: ElevatedButton.icon(
                  label: Text(widget.saveButtonText ?? 'Save'),
                  icon: Icon(
                    widget.saveButtonIcon ?? Icons.save,
                    size: 20.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: widget.saveButtonColor ?? Theme.of(context).colorScheme.primary,
                      onPrimary: widget.saveButtonTextColor ?? Theme.of(context).colorScheme.onPrimary),
                  onPressed:
                      _localDataSourceWithState.where((item) => item['checked']).length <= (widget.maxLength ?? -1)
                          ? () {
                              var selectedValuesObjectList =
                                  _localDataSourceWithState.where((item) => item['checked']).toList();
                              var selectedValues = [];
                              selectedValuesObjectList.forEach((item) {
                                selectedValues.add(item['value']);
                              });
                              Navigator.pop(context, selectedValues);
                            }
                          : null,
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

    var selectedValuesObjectList = _localDataSourceWithState.where((item) => item['checked']).toList();
    var selectedValues = [];
    selectedValuesObjectList.forEach((item) {
      selectedValues.add(item['value']);
    });
    selectedValues.forEach((item) {
      var existingItem = _localDataSourceWithState.singleWhere((itm) => itm['value'] == item, orElse: () => null);
      selectedOptions.add(Chip(
        label: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 80.0),
          child: Text(existingItem['text'], overflow: TextOverflow.ellipsis),
        ),
        deleteButtonTooltipMessage: widget.deleteButtonTooltipText ?? 'Tap to delete this item',
        deleteIcon: Icon(widget.deleteIcon ?? Icons.cancel),
        deleteIconColor: widget.deleteIconColor ?? Colors.grey,
        onDeleted: () {
          existingItem['checked'] = false;
          setState(() {});
        },
      ));
    });
    return selectedOptions.length > 0
        ? Container(
            padding: EdgeInsets.all(10.0),
            color: widget.selectedOptionsBoxColor ?? Colors.grey.shade400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  (widget.maxLength != null
                          ? (widget.maxLengthText ?? 'Maximum ${widget.maxLength} items') + '\n'
                          : '') +
                      (widget.selectedOptionsInfoText ??
                          'Currently selected ${selectedOptions.length} items (tap to remove)'), // use languageService here
                  style: TextStyle(
                      color: widget.selectedOptionsInfoTextColor ?? Colors.black87, fontWeight: FontWeight.bold),
                ),
                Container(height: 8),
                ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 8,
                    ),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                          child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 8.0, // gap between lines
                        alignment: WrapAlignment.start,
                        children: selectedOptions,
                      )),
                    )),
              ],
            ),
          )
        : Container();
  }

  ListView _optionsList() {
    List<Widget> options = [];
    _searchresult.forEach((item) {
      options.add(ListTile(
          selected: true,
          title: Text(item['text'] ?? ''),
          leading: Transform.scale(
            child: Icon(
                item['checked']
                    ? widget.checkedIcon ?? Icons.check_box
                    : widget.uncheckedIcon ?? Icons.check_box_outline_blank,
                color: widget.checkBoxColor ?? Theme.of(context).primaryColor),
            scale: 1.5,
          ),
          onTap: () {
            item['checked'] = !item['checked'];
            setState(() {});
          }));
      options.add(Divider(height: 1.0));
    });
    return ListView(children: options);
  }

  Widget _buildSearchText() {
    var textColor = widget.searchBoxTextColor ?? Colors.black87;
    var textStyle = Theme.of(context).textTheme.subtitle1?.copyWith(color: textColor);
    return Container(
      color: widget.searchBoxColor ?? Theme.of(context).primaryColor,
      padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            keyboardAppearance: Brightness.light,
            onChanged: searchOperation,
            style: textStyle,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 12, right: 12),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(const Radius.circular(6.0)),
              ),
              filled: true,
              hintText: widget.searchBoxHintText ?? "Search...",
              hintStyle: textStyle,
              fillColor: widget.searchBoxFillColor ?? Colors.white,
              suffix: Container(
                padding: EdgeInsets.only(top: 8),
                height: 32,
                child: IconButton(
                  iconSize: 24,
                  icon: Icon(widget.searchBoxIcon ?? Icons.clear, color: textColor),
                  onPressed: () {
                    _controller.clear();
                    searchOperation('');
                  },
                  padding: EdgeInsets.all(0.0),
                  tooltip: widget.searchBoxToolTipText ?? 'Clear',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  void _clearSelection() {
    _localDataSourceWithState = _localDataSourceWithState.map((item) {
      item['checked'] = false;
      return item;
    }).toList();
    setState(() {});
  }

  void searchOperation(String searchText) {
    _searchresult.clear();
    if (_isSearching && searchText.toString().trim() != '') {
      for (int i = 0; i < _localDataSourceWithState.length; i++) {
        String data = '${_localDataSourceWithState[i]['value']} ${_localDataSourceWithState[i]['text']}';
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchresult.add(_localDataSourceWithState[i]);
        }
      }
    } else {
      _searchresult = List.from(_localDataSourceWithState);
    }
  }
}
