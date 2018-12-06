# flutter_multiselect

Flutter package for multi-select UI widget


## Getting Started

add package in your pubspec.yaml
flutter_multiselect: 0.0.1

and import in your project to start using the multiselect.

By default, there is no UI contro for multi-select in iOS and Android

This widget can be used for bridge that gap.

Sample Usage -  

new MultiSelect(
                autovalidate: false,
                titleText: title,
                validator: (value) {
                  if (value == null) {
                    return 'Please select one or more option(s)';
                  }
                },
                errorText: 'Please select one or more option(s)',
                dataSource: [
                                {
                                    "display": "Australia",
                                    "value": 1,
                                },
                                {
                                    "display": "Canada",
                                    "value": 1,
                                },
                                {
                                    "display": "India",
                                    "value": 3,
                                },
                                {
                                    "display": "United States",
                                    "value": 4,
                                }],
                textField: 'display',
                valueField: 'value',
                filterable: true,
                required: true,
                value: null,
                onSaved: (value) {
                  print('The value is $value');
                });

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
