/**
 * 单独配置需要的存储值
 *
 * Create by lzx on 2019/9/11.
 */

import 'package:my_flutter/base/sp_base.dart';

class SPUtil {

  // 记录是否是第一次使用app
  static putIsFirstUse(bool isFirstUse) {
    return SPBase.putObject('IS_FIRST_USE', isFirstUse);
  }

  static getIsFirstUse(bool isFirstUse) {
    return SPBase.getObject('IS_FIRST_USE', false);
  }
}
