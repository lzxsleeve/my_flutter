import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/routers/fluro_navigator.dart';
import 'package:my_flutter/util/file_helper.dart';
import 'package:my_flutter/util/toast_util.dart';
import 'package:path/path.dart' as p;

/// 文件管理页面 Create by lzx on 2019/10/21.

class FileManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FileManageState();
  }
}

class _FileManageState extends State<FileManagePage> {
  List<FileSystemEntity> files = [];
  MethodChannel _channel = MethodChannel('openFileChannel');
  Directory parentDir;
  ScrollController controller = ScrollController();
  int count = 0; // 记录当前文件夹中以 . 开头的文件和文件夹
  List<double> position = [];

  @override
  void initState() {
    super.initState();
    parentDir = Directory(FileHelper().sDCardDir);
    initPathFiles(FileHelper().sDCardDir);
  }

  Future<bool> onWillPop() async {
    if (parentDir.path != FileHelper().sDCardDir) {
      initPathFiles(parentDir.parent.path);
      jumpToPosition(false);
    } else {
      NavigatorUtils.pop(context);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          appBar: AppBar(
            brightness: Brightness.light,
            title: Text(
                parentDir?.path == FileHelper().sDCardDir
                    ? 'SD Card'
                    : p.basename(parentDir.path),
                style: TextStyle(color: Colors.black)),
            centerTitle: true,
            backgroundColor: Color(0xffeeeeee),
            elevation: 0.0,
            leading: parentDir?.path == FileHelper().sDCardDir
                ? Container()
                : IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.black),
                    onPressed: onWillPop),
          ),
          body: _buildBody()),
    );
  }

  _buildBody() {
    return files.length == 0 || files.length == count
        ? Center(child: Text('The folder is empty'))
        : Scrollbar(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              controller: controller,
              itemCount: files.length,
              itemBuilder: (BuildContext context, int index) {
                // 不显示隐藏文件,但file集合还保留着
                if (p.basename(files[index].path).substring(0, 1) == '.') {
                  return Container();
                }

                if (FileSystemEntity.isFileSync(files[index].path))
                  return _buildFileItem(files[index]);
                else
                  return _buildFolderItem(files[index]);
              },
            ),
          );
  }

  Widget _buildFileItem(FileSystemEntity file) {
    String modifiedTime = dateTimeFormat(file.statSync().modified.toLocal());

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset(FileHelper().selectIcon(p.extension(file.path))),
          title: Text(file.path.substring(file.parent.path.length + 1)),
          subtitle: Text(
              '$modifiedTime  ${FileHelper().getFileSize(file.statSync().size)}',
              style: TextStyle(fontSize: 12.0)),
        ),
      ),
      onTap: () {
        ToastUtil.show("打开${file.path}");
//        openFile(file.path);
      },
    );
  }

  Widget _buildFolderItem(FileSystemEntity file) {
    String modifiedTime = dateTimeFormat(file.statSync().modified.toLocal());

    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 0.5, color: Color(0xffe5e5e5))),
        ),
        child: ListTile(
          leading: Image.asset('assets/images/folder.png'),
          title: Row(
            children: <Widget>[
              Expanded(
                  child:
                      Text(file.path.substring(file.parent.path.length + 1))),
              Text(
                '${_calculateFilesCountByFolder(file)}项',
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          subtitle: Text(modifiedTime, style: TextStyle(fontSize: 12.0)),
          trailing: Icon(Icons.chevron_right),
        ),
      ),
      onTap: () {
        // 点进一个文件夹，记录进去之前的offset
        // 返回上一层跳回这个offset，再清除该offset
        position.add(controller.offset);
        initPathFiles(file.path);
        jumpToPosition(true);
      },
    );
  }

  // 初始化该路径下的文件、文件夹
  void initPathFiles(String path) {
    try {
      setState(() {
        parentDir = Directory(path);
        count = 0;
        sortFiles();
        count = _calculatePointBegin(files);
      });
    } catch (e) {
      print(e);
      print("Directory does not exist！");
    }
  }

  // 排序
  void sortFiles() {
    List<FileSystemEntity> _files = [];
    List<FileSystemEntity> _folder = [];

    for (var v in parentDir.listSync()) {
      if (FileSystemEntity.isFileSync(v.path))
        _files.add(v);
      else
        _folder.add(v);
    }

    _files.sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
    _folder
        .sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));
    files.clear();
    files.addAll(_folder);
    files.addAll(_files);
  }

  // 计算以 . 开头的文件、文件夹总数
  int _calculatePointBegin(List<FileSystemEntity> fileList) {
    int count = 0;
    for (var v in fileList) {
      if (p.basename(v.path).substring(0, 1) == '.') count++;
    }
    return count;
  }

  /// ListView 跳转位置
  /// isEnter 进入文件时传递true, 返回时传递false
  void jumpToPosition(bool isEnter) async {
    if (isEnter)
      controller.jumpTo(0.0);
    else {
      try {
        await Future.delayed(Duration(milliseconds: 1));
        controller?.jumpTo(position[position.length - 1]);
      } catch (e) {}
      position.removeLast();
    }
  }

  // 计算文件夹内 文件、文件夹的数量，以 . 开头的除外
  int _calculateFilesCountByFolder(Directory path) {
    var dir = path.listSync();
    int count = dir.length - _calculatePointBegin(dir);

    return count;
  }

  // 日期格式转换  yyyy-MM-dd HH:mm:ss
  dateTimeFormat(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}";
  }

  // 打开文件
  Future openFile(String path) async {
    final Map<String, dynamic> args = <String, dynamic>{'path': path};
    await _channel.invokeMethod('openFile', args);
  }
}
