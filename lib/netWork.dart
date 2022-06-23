import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
class NetWorkPage extends StatefulWidget {
  NetWorkPage({Key ? key}) : super(key:key);

  @override
  State<NetWorkPage> createState() => _NetWorkPageState();
}

class _NetWorkPageState extends State<NetWorkPage> {

  @override
  String connectUrl = "";
  void initState() {
    super.initState();
    //获取网络连接
    isConnectedType();
    // //设置监听
    connectListener();
  }

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

  @override
  Widget build(BuildContext context) {
    if(_netType == "wifi"){
      connectUrl = "https://chart.zhixingxn.com/dispatching/index";
    }else{
      connectUrl = "https://www.baidu.com";
    }
    print(connectUrl);
    return Scaffold(
        body: Column(
        children: <Widget>[
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(connectUrl)),
              initialOptions: options

            ),
          )
    ],)
        // body: InAppWebView(
        //   initialOptions: options,
        //   initialUrlRequest: URLRequest(url: Uri.parse(connectUrl)),
        // ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("检测网络变化"),
    //   ),
    //   body: Center(child: Text("Connection Status:$_netType"))
    // );
  }

  Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  //获取网络类型
  var _netType;
  void isConnectedType () async {
    //获取网络类型
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile){
      _netType = "4G";
    }else if(connectivityResult == ConnectivityResult.wifi){
      _netType = "wifi";
    }else{
      _netType = "none";
    }
    setState(() {});
  }

  //添加网络监听
  void connectListener () async {
    // 获取 Stream
    Stream<ConnectivityResult> resultStream =
        Connectivity().onConnectivityChanged;
      resultStream.listen((ConnectivityResult result) {
        if(result == ConnectivityResult.mobile){
          _netType = "4G";
        }else if(result == ConnectivityResult.wifi){
          _netType = "wifi";
        }else{
          _netType = "none";
        }
      });
  }



























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
}

