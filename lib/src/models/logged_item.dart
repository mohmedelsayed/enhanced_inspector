enum LoggedItemParameters {
  itemName(0, 'itemName'),
  itemValue(1, 'itemValue'),
  itemId(2, 'itemId'),
  loggedTime(3, 'loggedTime'),
  loggedFromFile(4, 'loggedFromFile'),
  errorInFile(5, 'errorInFile'),
  errorInMethod(6, 'errorInMethod'),
  errorInLogic(7, 'errorInLogic');

  final int id;
  final String name;
  const LoggedItemParameters(this.id, this.name);
  @override
  String toString() => name;
  String get key => name;
  int toInt() => id;
}

class LoggedItem {
  String? itemName;
  String? itemValue;
  String? itemId;
  DateTime? loggedTime;
  String? loggedFromFile;
  String? errorInFile;
  String? errorInMethod;
  String? errorInLogic;

  LoggedItem({
    this.itemName,
    this.itemValue,
    this.itemId,
    this.loggedTime,
    this.loggedFromFile,
    this.errorInFile,
    this.errorInMethod,
    this.errorInLogic,
  });
  //fromJson
  LoggedItem.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    itemValue = json['itemValue'];
    itemId = json['itemId'];
    loggedTime = json['loggedTime'];
    loggedFromFile = json['loggedFromFile'];
    errorInFile = json['errorInFile'];
    errorInMethod = json['errorInMethod'];
    errorInLogic = json['errorInLogic'];
  }
  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['itemName'] = itemName;
    data['itemValue'] = itemValue;
    data['itemId'] = itemId;
    data['loggedTime'] = loggedTime;
    data['loggedFromFile'] = loggedFromFile;
    data['errorInFile'] = errorInFile;
    data['errorInMethod'] = errorInMethod;
    data['errorInLogic'] = errorInLogic;
    return data;
  }
}
