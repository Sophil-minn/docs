import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import './sign.dart';

class Axios {
  static Axios get instance => _getInstance();
  static Axios _instance;
  Dio dio;

  Axios._internal() {
    // init
// 或者通过传递一个 `options`来创建dio实例
    Object _options = Options(
      // 请求基地址,可以包含子路径，如: "https://xxxx.com/api/".
      baseUrl: "http://service205.mzftech.cn/",
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 5000,

      ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
      ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
      ///  注意: 这并不是接收数据的总时限.
      receiveTimeout: 3000,
      headers: {
        // 'user-agent': 'dio',
        "contentType": ContentType.parse("application/json"),
        // "sign": '6896823967def669e294f0bf163d193e',
      },
    );

    dio = new Dio(_options);

    dio.interceptor.request.onSend = (Options options) {
      // 在请求被发送之前做一些事情

      // 加其它信息
      options.headers['tendId'] = 6;
      options.headers['version'] = '1.0.0';
      options.headers['aliasName'] = 'sfd';
      options.headers['clientType'] = '4';
      // token
      // options.headers['token'] = 'ff';
      // 加签
      options.headers["sign"] = sign(options.data.toString());
      print(options.headers["sign"]);

      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    };

    dio.interceptor.response.onSuccess = (Response response) {
      // 在返回响应数据之前做一些预处理
      int statusCode = response.statusCode;
      switch (statusCode) {
        case 126000:
          break;
        case 126020:
        case 12888:
          break;
        case 120007:
          break;
        default:
      }
      return response; // continue
    };

    dio.interceptor.response.onError = (DioError e) {
      // 当请求失败时做一些预处理
      return DioError; //continue
    };
  }

  static Axios _getInstance() {
    if (_instance == null) {
      _instance = new Axios._internal();
    }
    return _instance;
  }

  get(url, {data, options}) async {
    return await dio.get(url, data: data, options: options);
  }

  post(url, {data, options}) async {
    return await dio.post(url, data: data, options: options);
  }
}

// print(utf8.encode("ff"));

const CONTENT_TYPE_JSON = "application/json";
const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";
