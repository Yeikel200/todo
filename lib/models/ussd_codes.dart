import 'package:flutter/material.dart';
import 'package:todo/utils/icons.dart';

class UssdRoot {
  List<UssdItem> items;

  UssdRoot({this.items});

  factory UssdRoot.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<UssdItem> itemList = list.map((i) => UssdItem.fromJson(i)).toList();

    return UssdRoot(items: itemList);
  }
}

abstract class UssdItem {
  String name;
  IconData icon;
  String type;
  String description;

  UssdItem({this.name, this.icon, this.type, this.description});

  factory UssdItem.fromJson(Map<String, dynamic> parsedJson) {
    final type = parsedJson['type'];

    if (type == 'code') {
      return UssdCode.fromJson(parsedJson);
    } else {
      return UssdCategory.fromJson(parsedJson);
    }
  }
}

class UssdCategory extends UssdItem {
  List<UssdItem> items;

  UssdCategory({name, icon, description, this.items})
      : super(
            name: name, icon: icon, type: 'category', description: description);

  factory UssdCategory.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    List<UssdItem> itemList = list.map((i) => UssdItem.fromJson(i)).toList();

    var icon;
    try {
      icon = strIcons[parsedJson['icon']];
    } catch (e) {
      icon = Icons.code;
    }

    return UssdCategory(
      name: parsedJson['name'],
      icon: icon,
      description: parsedJson['description'],
      items: itemList,
    );
  }
}

class UssdCode extends UssdItem {
  String code;

  List<UssdCodeField> fields;

  UssdCode({name, icon, description, this.code, this.fields})
      : super(name: name, icon: icon, type: 'code', description: description);

  factory UssdCode.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['fields'] as List;
    List<UssdCodeField> fieldsList =
        list.map((i) => UssdCodeField.fromJson(i)).toList();

    var icon;

    try {
      icon = strIcons[parsedJson['icon']];
    } catch (e) {
      icon = Icons.code;
    }

    return UssdCode(
      name: parsedJson['name'],
      icon: icon,
      code: parsedJson['code'],
      description: parsedJson['description'],
      fields: fieldsList,
    );
  }
}

class UssdCodeField {
  String name;
  String type;

  UssdCodeField({this.name, this.type});

  factory UssdCodeField.fromJson(Map<String, dynamic> parsedJson) {
    return UssdCodeField(name: parsedJson['name'], type: parsedJson['type']);
  }
}
