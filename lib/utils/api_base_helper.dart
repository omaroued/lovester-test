import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class ApiBasehelper {
  ApiBasehelper._();



  static Future<http.Response> get(
    String url, {
    required Logger logger,
    Map<String, String>? headers,
  }) async {
    logger.info("GET: " + url);
    return http.get(Uri.parse(url), headers: headers);
  }

  static Future<http.Response> post(
    String url, {
    required Logger logger,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    logger.info("POST: " + url);
    return http.post(Uri.parse(url), headers: headers, body: json.encode(body));
  }

  static Future<http.Response> put(
    String url, {
    required Logger logger,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    logger.info("PUT: " + url);
    return http.put(Uri.parse(url), headers: headers, body: json.encode(body));
  }

  static Future<http.Response> delete(
    String url, {
    required Logger logger,
    Map<String, String>? headers,
  }) async {
    logger.info("DELETE: " + url);
    return http.delete(Uri.parse(url), headers: headers);
  }

  static Map<String,String> headers(BuildContext context,{bool needKey=true}){
    
      return  {
        "Content-Type": "application/json"
      };


  }
}
