# flutter_multiselect

Flutter package for multi-select UI widget

## Getting Started

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
