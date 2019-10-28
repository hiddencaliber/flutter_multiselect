
# flutter_multiselect

Flutter package for multi-select UI widget

[![pub package](https://img.shields.io/badge/flutter__multiselect-v0.2.0-green.svg)](https://pub.dartlang.org/packages/flutter_multiselect)


Android and iOS screenshot-
![screenshot](https://i.imgur.com/YEalQ1R.png)


## Getting Started

- Add the package into `pubspec.yaml`

```yaml
dependencies:
  flutter_multiselect: 0.0.1
```

- Import in your code

```dart
import 'package:flutter_multiselect/flutter_multiselect.dart';
```

## Why?

By default, there is no UI control for multi-select in iOS and Android, and my widget can be used to bridge this gap.

## Example
```dart
child: MultiSelect(
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
      "value": 2,
    },
    {
      "display": "India",
      "value": 3,
    },
    {
      "display": "United States",
      "value": 4,
    }
  ],
  textField: 'display',
  valueField: 'value',
  filterable: true,
  required: true,
  value: null,
  onSaved: (value) {
    print('The value is $value');
  }
),
```
