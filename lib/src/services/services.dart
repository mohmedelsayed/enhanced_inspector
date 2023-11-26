String extractTimeText(DateTime sentTime) {
  var sentTimeText = sentTime.toIso8601String().split('T').last.substring(0, 8);
  sentTimeText = _replaceLastSeparatorWithDot(sentTimeText);
  return sentTimeText;
}

String _replaceLastSeparatorWithDot(String sentTimeText) => sentTimeText.replaceFirst(':', '.', 5);
