import 'package:flutter/material.dart';
import 'netWork.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NetWorkPage()
      //const MyHomePage(title: ''),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//         initialOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(),
//         ),
//         initialUrlRequest:
//         URLRequest(url: Uri.parse("https://chart.zhixingxn.com/punchingwelding/index")),
//       ),
//     );
//   }
// }
