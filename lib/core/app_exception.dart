import 'dart:io';

import 'package:logging/logging.dart';

class AppException{
  final String message;

  AppException({required this.message});


  static AppException formatServiceException(Logger logger,Object e, StackTrace? stack){
    if (e is AppException) {
      logger.severe(e.message);
      return e;
    } else if (e is SocketException) {
      return AppException(
          message:
          "Can't reach the server. Check your internet connection!");
    } else {
      logger.severe("Unknown error!",e,stack);
      return AppException(message: "Unknown error!");
    }
  }


}