import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final WebViewController _controller;

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
  }

  Future<void> _sendMessage() async{
    await _controller.runJavaScript("showMessageFromFlutter('Hello From Flutter!')");
    final result = await _controller.runJavaScriptReturningResult("showMessageFromFlutter('Hello From Flutter with return value')");
    debugPrint("JS return: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       actions: [IconButton(onPressed: _sendMessage, icon: Icon(Icons.send))],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

const String htmlContent = """
<!DOCTYPE html>
<html>
<head>
  <title>JS from Flutter</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
  <h1>Web Page</h1>
  <p id="msg">No message yet</p>

  <script>
    function showMessageFromFlutter(msg) {
      document.getElementById('msg').innerText = "Flutter says: " + msg;
      return "Message received: " + msg;
    }
  </script>
</body>
</html>
""";