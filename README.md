# flutter_multiselect

Flutter package for multi-select UI widget

[![pub package](https://img.shields.io/badge/flutter__multiselect-v%200.6.0-brightgreen)](https://pub.dartlang.org/packages/flutter_multiselect)

Android and iOS screenshot-
![screenshot](https://i.imgur.com/YEalQ1R.png)

## Getting Started

- Add the package into `pubspec.yaml`

```yaml
dependencies:
  flutter_multiselect:
```

- Import in your code

```dart
import 'package:flutter_multiselect/flutter_multiselect.dart';
```

## Why? :wrench:

By default, there is no UI control for multi-select in iOS and Android, and my widget can be used to bridge this gap.

## Example without customization :one:

```dart
child: MultiSelect(
  autovalidate: false,
  titleText: "Countries",
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

<p float="left">
<img src="https://github.com/WilliBobadilla/flutter_multiselect/blob/customization/example/screenshoots/1.jpeg"  width="25%" height="35%" />
<img src="https://github.com/WilliBobadilla/flutter_multiselect/blob/customization/example/screenshoots/2.jpeg"  width="25%" height="35%" />
<img src="https://github.com/WilliBobadilla/flutter_multiselect/blob/customization/example/screenshoots/3.jpeg"  width="25%" height="35%" />
<img src="https://github.com/WilliBobadilla/flutter_multiselect/blob/customization/example/screenshoots/4.jpeg"  width="25%" height="35%" />
</p>

## Example with customization :two:

Check the colors and text to see the changes that it makes to the modal interface

```dart
child: MultiSelect(
    //--------customization selection modal-----------
    buttonBarColor: Colors.red,
    cancelButtonText: "Exit",
    titleText: "Custom Title",
    checkBoxColor: Colors.black,
    selectedOptionsInfoText: "Selected custom text (tap to remove)",
    selectedOptionsBoxColor: Colors.green,
    autovalidate: true,
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
    })

```

and of course you can check the full list of the parameters to personalize your modal!

<p float="left">
<img src="https://github.com/WilliBobadilla/flutter_multiselect/blob/customization/example_customization_multiselect/screenshoots/1.jpeg"  width="25%" height="35%" />
</p>
