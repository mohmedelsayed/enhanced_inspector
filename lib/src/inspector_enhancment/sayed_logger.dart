import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../requests_inspector.dart';
import '../json_pretty_converter.dart';
import '../services/services.dart';

class SayedLogger extends StatelessWidget {
  const SayedLogger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Selector<InspectorController, List<LoggedItem>>(
        selector: (_, inspectorController) => inspectorController.logesList,
        shouldRebuild: (previous, next) => true,
        builder: (context, logsList, _) => logsList.isEmpty
            ? const Center(child: Text('No Loges to Show'))
            : _buildLogesList(context, logsList),
      ),
    );
  }

  Widget _buildLogesList(BuildContext context, List<LoggedItem> logs) {
    return ListView(
        padding: const EdgeInsets.only(bottom: 96.0),
        children: logs.isNotEmpty
            ? logs
                .map((item) => _buildExpandableCart(
                      item.itemName ?? 'Item Name',
                      _customColumn(loggedName: item.itemName, loggedValue: item.itemValue),
                    ))
                .toList()
            : []);
  }

  Widget _customColumn({String? loggedName, String? loggedValue}) {
    return Column(
      children: [
        SelectableText('${loggedName ?? 'Logged'} is : ${loggedValue ?? 'No Value'} '),
      ],
    );
  }

  Widget _buildExpandableCart(String title, Widget child) {
    var exTile = ExpansionTile(
      title: SelectableText(title),
      children: [
        child,
      ],
    );
    return exTile ??
        Container(
          height: 100,
          width: 100,
          color: Colors.red,
        );
  }

  Widget _buildBackgroundColor(index, item) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: index.isEven ? const Color.fromARGB(255, 208, 208, 208) : const Color(0xFFFFFFFF),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: item,
      ),
    );
  }

  Widget _buildRequestNameAndStatus({
    RequestMethod? method,
    String? requestName,
    int? statusCode,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _createRequestName(method, requestName),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: statusCode == null
                ? Colors.red[400]
                : statusCode > 299
                    ? Colors.red[400]
                    : Colors.green[400],
            child: Text(
              statusCode?.toString() ?? 'Err',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }

  String _createRequestName(RequestMethod? method, String? requestName) {
    return (method?.name == null ? '' : '${method!.name}: ') + (requestName ?? 'No name');
  }

  ///TODO: It's better to add the request duration as well!
  Widget _buildRequestSentTime(DateTime sentTime) {
    final sentTimeText = extractTimeText(sentTime);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'Sent at: $sentTimeText',
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  Iterable<Widget> _buildHeadersBlock(headers) {
    if (headers == null) return [];
    if ((headers is Map || headers is String || headers is List) && headers.isEmpty) return [];

    return [
      _buildTitle('Headers'),
      _buildSelectableText(headers),
    ];
  }

  Iterable<Widget> _buildQueryBlock(queryParameters) {
    if (queryParameters == null) return [];
    if ((queryParameters is Map || queryParameters is String || queryParameters is List) &&
        queryParameters.isEmpty) return [];

    return [
      _buildTitle('Parameters'),
      _buildSelectableText(queryParameters),
    ];
  }

  Iterable<Widget> _buildRequestBodyBlock(requestBody) {
    if (requestBody == null) return [];
    if ((requestBody is Map || requestBody is String || requestBody is List) && requestBody.isEmpty)
      return [];

    return [
      _buildTitle('RequestBody'),
      _buildSelectableText(requestBody),
    ];
  }

  Iterable<Widget> _buildResponseBodyBlock(responseBody) {
    if (responseBody == null) return [];
    if ((responseBody is Map || responseBody is String || responseBody is List) &&
        responseBody.isEmpty) return [];

    return [
      _buildTitle('ResponseBody'),
      _buildSelectableText(responseBody),
    ];
  }

  Widget _buildSelectableText(text) {
    final prettyprint = JsonPrettyConverter().convert(text);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SelectableText(prettyprint),
    );
  }

  Widget _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
