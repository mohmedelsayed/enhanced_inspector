# requests_inspector 🕵

A Flutter package for logging API requests and accessing it by **Shaking** your phone to get the `RequestsInspector` widget on your screen.

### First, add it at the top of your `MaterialApp` with `enabled: true`.

```dart
void main() {
  runApp(const RequestsInspector(
    enabled: true,
    child: MyApp(),
  ));
}

```

**Note:** Don't forget to `enable` it!

### Then, on your API request add a new `RequestDetails` using `RequestInspectorController` filled with the API data.

```dart
RequestsInspectorController().addNewRequest(
    RequestDetails(
        requestName: 'Posts',
        requestMethod: RequestMethod.GET,
        url: 'https://jsonplaceholder.typicode.com/posts',
        statusCode: response.statusCode,
        responseBody: response.data,
        sentTime: DateTime.now(),
        ),
    );
```

### Finlay, `Shake` your phone to get your `Inspector`

<img src = "./screenshots/Screenshot_20211211-004944.jpg" width ="300" />
<img src = "./screenshots/Screenshot_20211211-004949.jpg" width ="300" />

We are done 🎉️ 😁️
