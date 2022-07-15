import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
extension ParseToString on ConnectivityResult {
  String toValue() {
    return this.toString().split('.').last;
  }
}
class ConnectivityStatusExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConnectivityStatusExampleState();
  }
}
class _ConnectivityStatusExampleState extends State<ConnectivityStatusExample> {
  static const TextStyle textStyle = const TextStyle(
    fontSize: 16,
  );
  final GlobalKey webViewKey = GlobalKey();
  var _connectUrl = "";
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    /// android 支持HybridComposition
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );
  ConnectivityResult? _connectivityResult;
  late StreamSubscription _connectivitySubscription;
  bool? _isConnectionSuccessful;
  @override
  initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        if(result == ConnectivityResult.wifi){
          _connectUrl='https://chart.zhixingxn.com/painting/index';
        }
        _connectivityResult = result;
      });
    });
  }
  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }
  Future<void> _checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      print('Connected to a Wi-Fi network');
    } else if (result == ConnectivityResult.mobile) {
      print('Connected to a mobile network');
    } else {
      print('Not connected to any network');
    }
    setState(() {
      _connectivityResult = result;
    });
  }

  Future<void> _tryConnection() async {
    try {
      final response = await InternetAddress.lookup('https://www.baidu.com');
      setState(() {
        _isConnectionSuccessful = response.isNotEmpty;
      });
    } on SocketException catch (e) {
      print(e);
      setState(() {
        _isConnectionSuccessful = false;
      });
    }
  }
  bool _flag = true;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   title: const Text('App标题'),
      //   centerTitle: true,
      //   backgroundColor: Colors.teal,
      // ),
      body:Column(
          children: [
            // this._flag ? _getMoreWidget() : Text(
            //   '',
            //   style: TextStyle(height: 0),
            // ),
            Expanded(
                child: InAppWebView(
                  key: webViewKey,
                  initialOptions: options,
                  initialUrlRequest: URLRequest(
                    url: Uri.parse('https://chart.zhixingxn.com/painting/index')),
                    onProgressChanged: (controller, progress) {
                      if (progress / 100 > 0.9999) {
                        setState(() {
                          this._flag = false;
                        });
                      }
                    },
                )
            )
          ],
      )
      // body: SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         'Connection status: ${_connectivityResult?.toValue()}',
      //         style: textStyle,
      //       ),
      //       Text(
      //         'Is connection success: $_isConnectionSuccessful',
      //         style: textStyle,
      //       ),
      //       OutlinedButton(
      //         child: const Text('Check internet connection'),
      //         onPressed: () => _checkConnectivityState(),
      //       ),
      //       OutlinedButton(
      //         child: const Text('Try connection'),
      //         onPressed: () => _tryConnection(),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '网页加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }
}










// class NetWorkPage extends StatefulWidget {
//   NetWorkPage({Key ? key}) : super(key:key);
//
//   @override
//   State<NetWorkPage> createState() => _NetWorkPageState();
// }
//
// class _NetWorkPageState extends State<NetWorkPage> {
//
//   final GlobalKey webViewKey = GlobalKey();
//
//   @override
//   String connectUrl = "";
//   void initState() {
//     super.initState();
//     //获取网络连接
//     isConnectedType();
//     // //设置监听
//     connectListener();
//   }
//
//   InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
//     crossPlatform: InAppWebViewOptions(
//       useShouldOverrideUrlLoading: true,
//       mediaPlaybackRequiresUserGesture: false,
//     ),
//     /// android 支持HybridComposition
//     android: AndroidInAppWebViewOptions(
//       useHybridComposition: true,
//     ),
//     ios: IOSInAppWebViewOptions(
//       allowsInlineMediaPlayback: true,
//     ),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     print(_netType);
//     if(_netType == "wifi"){
//       connectUrl = "https://chart.zhixingxn.com/dispatching/index";
//     }else{
//       connectUrl = "https://www.baidu.com";
//     }
//     print(connectUrl);
//     return Scaffold(
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: InAppWebView(
//                   key: webViewKey,
//                   initialUrlRequest: URLRequest(url: Uri.parse("https://chart.zhixingxn.com/autocheck/index")),
//                   initialOptions: options
//               ),
//             )
//           ],)
//       // body: InAppWebView(
//       //   initialOptions: options,
//       //   initialUrlRequest: URLRequest(url: Uri.parse(connectUrl)),
//       // ),
//     );
//     // return Scaffold(
//     //   appBar: AppBar(
//     //     title: Text("检测网络变化"),
//     //   ),
//     //   body: Center(child: Text("网络连接失败"))
//     // );
//   }
//
//   Future<bool> isConnected() async {
//     var connectivityResult = await (Connectivity().checkConnectivity());
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   //获取网络类型
//   var _netType = "";
//   void isConnectedType () async {
//     //获取网络类型
//     ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
//     print("huhao check ${connectivityResult}");
//     if(connectivityResult == ConnectivityResult.mobile){
//       _netType = "4G";
//     }else if(connectivityResult == ConnectivityResult.wifi){
//       _netType = "wifi";
//     }else{
//       _netType = "none";
//     }
//     setState(() {});
//   }
//   late Stream<ConnectivityResult> resultStream;
//   //添加网络监听
//   void connectListener () async {
//     // 获取 Stream
//     resultStream =
//         Connectivity().onConnectivityChanged;
//     resultStream.listen((ConnectivityResult result) {
//       print("huhao listen ${result}");
//       if(result == ConnectivityResult.mobile){
//         _netType = "4G";
//       }else if(result == ConnectivityResult.wifi){
//         _netType = "wifi";
//       }else{
//         _netType = "none";
//       }
//       setState(() {});
//     });
//   }



























// var subscription;
// var _state = "1";
// String url = "";
// @override
// void initState() {
//   super.initState();
//   subscription = new Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//     if (result.toString() == "ConnectivityResult.wifi") {
//       setState(() {
//         _state = "1";
//       });
//     } else if (result.toString() == "ConnectivityResult.mobile") {
//       setState(() {
//         _state = "2";
//       });
//     } else {
//       setState(() {
//         _state = "0";
//       });
//     }
//   });
// }
//
// InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
//   crossPlatform: InAppWebViewOptions(
//     useShouldOverrideUrlLoading: true,
//     mediaPlaybackRequiresUserGesture: false,
//   ),
//   /// android 支持HybridComposition
//   android: AndroidInAppWebViewOptions(
//     useHybridComposition: true,
//   ),
//   ios: IOSInAppWebViewOptions(
//     allowsInlineMediaPlayback: true,
//   ),
// );
//
// @override
// Widget build(BuildContext context) {
//   if(_state == "1"){
//     url = "https://chart.zhixingxn.com/dispatching/index";
//   }else{
//     url = "https://www.baidu.com";
//   }
//   return Scaffold(
//       body: InAppWebView(
//         initialOptions: options,
//         initialUrlRequest: URLRequest(url: Uri.parse(url)),
//       ),
//   );
//   // return Scaffold(
//   //   appBar: AppBar(
//   //     title: Text("检测网络变化"),
//   //   ),
//   //   body: Center(child: Text('Connection Status: $_connectionStatus\n'))
//   // );
// }
//
// @override
// void dispose() {
//   super.dispose();
//   subscription.cancel();
// }
// }

