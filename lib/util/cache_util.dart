import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'log_util.dart';

/// 缓存工具类 Create by lzx on 2019/11/4.

class CacheUtil {
  /// 加载缓存
  /// 注: 获取的是可安全清除的临时文件，并不是应用的总缓存
  /// [function] 获取缓存文件大小后执行的方法
  static Future<Null> loadCache(Function function(double cacheSize)) async {
    try {
      Directory tempDir = await getTemporaryDirectory();
      double value = await _getTotalSizeOfFilesInDir(tempDir);
      /*tempDir.list(followLinks: false,recursive: true).listen((file){
          //打印每个缓存文件的路径
        print(file.path);
      });*/
      LogUtil.i('临时目录大小: ' + value.toString(), tag: "CacheUtil");
      LogUtil.i('临时目录路径: ' + tempDir.toString(), tag: "CacheUtil");
      function(value);
    } catch (err) {
      LogUtil.e(err);
    }
  }

  /// 递归方式 计算文件的大小
  static Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    try {
      if (file is File) {
        int length = await file.length();
        return double.parse(length.toString());
      }
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        double total = 0;
        if (children != null) for (final FileSystemEntity child in children) total += await _getTotalSizeOfFilesInDir(child);
        return total;
      }
      return 0;
    } catch (e) {
      LogUtil.e(e);
      return 0;
    }
  }

  /// 清除缓存
  /// [clearAfter] 删除缓存文件之后的操作，如：更新缓存数据
  /// [clearBefore] 删除缓存文件之前的操作，如：展示加载loading
  /// [clearFinally] 删除缓存文件最后的操作，如：隐藏加载loading
  static void clearCache({Function clearAfter, Function clearBefore, Function clearFinally}) async {
    _functionIsNotNull(clearBefore);
    try {
      Directory tempDir = await getTemporaryDirectory();
      //删除缓存目录
      await delDir(tempDir);
      _functionIsNotNull(clearAfter);
      LogUtil.i('清除缓存成功', tag: "CacheUtil");
    } catch (e) {
      LogUtil.i('清除缓存失败：$e', tag: "CacheUtil");
    } finally {
      _functionIsNotNull(clearFinally);
    }
  }

  /// 递归方式删除目录
  static Future<Null> delDir(FileSystemEntity file) async {
    try {
      if (file is Directory) {
        final List<FileSystemEntity> children = file.listSync();
        for (final FileSystemEntity child in children) {
          await delDir(child);
        }
      }
      await file.delete();
    } catch (e) {
      LogUtil.e(e);
    }
  }

  /// 格式化文件大小
  static String renderSize(double value) {
    if (value == null) {
      return "0B";
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 判断方法是否为空，不为空则执行
  static _functionIsNotNull(Function function) {
    if (function != null) {
      function();
    }
  }
}
