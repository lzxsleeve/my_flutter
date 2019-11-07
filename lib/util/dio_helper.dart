import 'package:dio/dio.dart';
import 'package:my_flutter/base/global_config.dart';

/// ko no dio da
/// dio网络请求,主要负责dio的一些配置
/// Create by lzx on 2019/11/5.
class DioHelper {
  factory DioHelper() => _getInstance();

  static DioHelper get instance => _getInstance();
  static DioHelper _instance;

  static Dio _dio;
  static BaseOptions _options = getDefOptions();
  static String _baseUrl = "http://gank.io/api/";

  DioHelper._internal() {
    // 初始化
    _dio = new Dio();
    _dio.options = _options;
    _dio.interceptors.add(LogInterceptor(responseBody: GlobalConfig.isDebug));
  }

  static DioHelper _getInstance() {
    if (_instance == null) {
      _instance = new DioHelper._internal();
    }
    return _instance;
  }

  static BaseOptions getDefOptions() {
    BaseOptions options = BaseOptions();
    options.connectTimeout = 10 * 1000;
    options.receiveTimeout = 20 * 1000;
    options.baseUrl = _baseUrl;

    // 统一设置头部
//    Map<String, dynamic> headers = Map<String, dynamic>();
//
//    String platform;
//    if(Platform.isAndroid) {
//      platform = "Android";
//    } else if(Platform.isIOS) {
//      platform = "IOS";
//    }
//    headers['OS'] = platform;
//    options.headers = headers;

    return options;
  }

  setOptions(BaseOptions options) {
    _options = options;
    _dio.options = _options;
  }

  // 添加拦截器
  addInterceptor(Interceptor interceptor) {
    if (_dio != null) {
      _dio.interceptors.add(interceptor);
    }
  }

  addInterceptors(List<Interceptor> interceptorList) {
    if (_dio != null) {
      _dio.interceptors.addAll(interceptorList);
    }
  }

  get(String path, {Map<String, dynamic> params, options, Function success, Function failure}) async {
    try {
      Response response = await _dio.get(path, queryParameters: params, options: options);
      _functionIsNotNull(success, param: response);
    } catch (exception) {
      _functionIsNotNull(failure, param: exception);
    }
  }

  post(String path, {Map<String, dynamic> params, data, options, Function success, Function failure}) async {
    try {
      Response response = await _dio.post(path, queryParameters: params, data: data, options: options);
      _functionIsNotNull(success, param: response);
    } catch (exception) {
      _functionIsNotNull(failure, param: exception);
    }
  }

  /// 判断方法是否为空，不为空则执行
  void _functionIsNotNull(Function function, {param}) {
    if (function != null) {
      function(param);
    }
  }
}
