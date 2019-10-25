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
  var _isHide = true;
  var _currentUrl = '';
  var _isError = false;
  Container _otherView = _loadingView();

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
                  return NavigationDecision.navigate;
                },
                initialUrl: widget.url,
                // 加载的url
                onWebViewCreated: (WebViewController web) {
                  webViewController = web;
                },
                onPageFinished: (String url) {
                  // webview 页面加载完成
                  print('lzx: onPageFinished $url');
                  if (!_isError) {
                    setState(() {
                      _isHide = false;
                    });
                  }
                },
                onPageReceiveError: (String url, int code, String description) {
                  print("lzx: onError url = $url, code = $code, description = $description");
                  if (_currentUrl == url) {
                    print("lzx: onError: _currentUrl == url");
                    _isError = true;
                    setState(() {
                      _isHide = true;
                      _otherView = _errorView();
                    });
                  }
                },
                onPageStarted: (String url) {
                  print("lzx: onPageStarted url=$url");
                  _currentUrl = url;
                  _isError = false;

                  setState(() {
                    _isHide = true;
                    _otherView = _loadingView();
                  });
                },
              ),
            ),
            // 显示 正在加载 或 加载错误 的界面
            GestureDetector(
              onTap: () {
                ToastUtil.show("lzx");
                if (_isError) {
                  webViewController.reload();
                }
              },
              child: Visibility(
                visible: _isHide,
                child: _otherView,
              ),
            ),
          ],
        ),
      ),
    );
  }

// webView的加载视图
  static Widget _loadingView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: Colors.white),
      alignment: Alignment.center,
      child: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Color(0x88000000), borderRadius: BorderRadius.circular(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircularProgressIndicator(),
            Text(
              '正在加载',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  static Widget _errorView() {
    return Container(
      // 添加背景颜色后，onTap全屏生效
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/pic_load_error.png',
            height: 100,
            width: 100,
          ),
          Text("加载失败，点击重试"),
        ],
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
