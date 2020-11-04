import 'package:flutter/material.dart';

var textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
    ),
    borderRadius: BorderRadius.circular(10.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      width: 3.0,
      color: Colors.blueAccent,
    ),
    borderRadius: BorderRadius.circular(10.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(10.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.red,
    ),
    borderRadius: BorderRadius.circular(10.0),
  ),
);

var searchInputDecoration = InputDecoration(
  fillColor: Colors.grey,
  focusColor: Colors.grey,
  hoverColor: Colors.grey,
  prefixIcon: Icon(Icons.search),
  border: InputBorder.none,
);

var noteInputDecoration = InputDecoration(
  fillColor: Color.fromRGBO(234, 236, 238, 1),
  filled: true,
  focusColor: Colors.grey,
  hoverColor: Colors.grey,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
);
var registerInputDecoration = InputDecoration(
  fillColor: Color.fromRGBO(234, 236, 238, 1),
  filled: true,
  focusColor: Colors.grey,
  hoverColor: Colors.grey,
  border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
);
