import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

// 或者通过传递一个 `options`来创建dio实例
Object _options = Options(
  // 请求基地址,可以包含子路径，如: "https://www.google.com/api/".
  baseUrl: "http://service.mzftech.cn/",
  //连接服务器超时时间，单位是毫秒.
  connectTimeout: 5000,

  ///  响应流上前后两次接受到数据的间隔，单位为毫秒。如果两次间隔超过[receiveTimeout]，
  ///  [Dio] 将会抛出一个[DioErrorType.RECEIVE_TIMEOUT]的异常.
  ///  注意: 这并不是接收数据的总时限.
  receiveTimeout: 3000,
  headers: {
    'user-agent': 'dio',
    "contentType": ContentType.parse("application/json"),
    // "sign": '6896823967def669e294f0bf163d193e',
  },
);

// print(utf8.encode("ff"));

const CONTENT_TYPE_JSON = "application/json";
const CONTENT_TYPE_FORM = "application/x-www-form-urlencoded";

// dio.interceptor.request.onSend=null;
// dio.interceptor.response.onSuccess=null;
// dio.interceptor.response.onError=null;

Dio dio = new Dio(_options);
