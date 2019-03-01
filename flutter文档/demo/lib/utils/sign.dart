import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

String sign(String data) {
  // String str = json.decode(data);
  var content = new Utf8Encoder().convert(data);
  //直接把utf8 -> md5: digest = md5.convert(content);
  // or utf8->b64->md5
  var b64content = base64Encode(content);
  content = new Utf8Encoder().convert(b64content);
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}
