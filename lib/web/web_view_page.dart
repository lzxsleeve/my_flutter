/**
 * 网页 (暂时没有独立的错误界面)
 *
 * Create by lzx on 2019/8/30.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage({this.url, this.title});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  WebViewController webViewController;
  var loadingState = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text(widget.title),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String value) {
                ToastUtil.show(value);
                switch (value) {
                  case 'refresh':
                    webViewController.reload();
                    break;
                  case 'setting':
                    ToastUtil.show("设置");
                    break;
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                PopupMenuItem(
                  value: 'refresh',
                  child: ListTile(
                    leading: Icon(Icons.refresh),
                    title: Text('刷新'),
                  ),
                ),
                PopupMenuItem(
                  value: 'setting',
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('设置'),
                  ),
                )
              ],
            ),
          ],
        ),
        body: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request) {
                  print("lzx: OnUrlChange ${request.url}");
                  setState(() {
                    loadingState = true;
                  });
                  return NavigationDecision.navigate;
                },
                initialUrl: widget.url, // 加载的url
                onWebViewCreated: (WebViewController web) {
                  webViewController = web;
                },
                onPageFinished: (String value) {
                  // webview 页面加载完成
                  print('lzx: onPageFinished $value');
                  setState(() {
                    loadingState = false;
                  });
                },
              ),
            ),
            Visibility(
              visible: loadingState,
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                height: double.infinity,
                width: double.infinity,
                child: Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0x88000000),
                      borderRadius: BorderRadius.circular(6)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text(
                        '正在加载...',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (webViewController != null) {
      webViewController.canGoBack().then((canBack) {
        if (canBack) {
          webViewController.goBack();
        } else {
          Navigator.pop(context);
        }
      });
    }
    return new Future.value(false);
  }
}
