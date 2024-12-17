// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'package:flutter/material.dart';

class SearchResult {
  int itemIndex = -1;
  String query = "";
  int startQueryIndex = -1;
  List<TextSpan> searchPreview = [];
  String target = "";
  SearchResult(
      int item_index, String _query, int start_query_index, String _target) {
    itemIndex = item_index;
    query = _query;
    startQueryIndex = start_query_index;
    target = _target;
    TextStyle highlightStyle = const TextStyle(backgroundColor: Colors.amber);

    searchPreview.add(TextSpan(text: target.substring(0, start_query_index)));
    searchPreview.add(TextSpan(
        text: target.substring(
            start_query_index, start_query_index + query.length),
        style: highlightStyle));
    searchPreview.add(
        TextSpan(text: target.substring(start_query_index + query.length)));
  }
}
