import 'package:flutter/material.dart';

InputDecoration searchInputDecoration() {
  return InputDecoration(
    fillColor: Colors.grey[200],
    filled: true,
    prefixIcon: Icon(Icons.search),
    hintText: 'Email',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
  );
}