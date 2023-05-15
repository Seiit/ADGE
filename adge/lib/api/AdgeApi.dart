import 'dart:convert';
import 'dart:typed_data';
import 'package:adge/services/alert_service.dart';
import 'package:adge/services/local_storage.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:adge/utils/api_error_utils.dart';
import 'package:dio/dio.dart';

class AdgeApi {
  static Dio _dio = new Dio();

  static void configureDio() {
    var token = LocalStorage.prefs.getString('token') ?? '';
    _dio.options.baseUrl = 'http://localhost:3000';
    _dio.options.headers = {
      "Content-Type": "application/json",
      "X-Requested-With": "XMLHttpRequest",
      "Authorization": "Bearer $token"
    };
  }

  static Future Post(String path, Map<String, dynamic> data, context) async {
    final fromData = json.encode(data);

    try {
      final res = await _dio.post(path, data: fromData);

      if (res.data['result']['success'] == false) {
        AlertService.alertApiError(
            context, ApiErrorUtils.getErrors(res.data['result']));
        return null;
      }

      return res.data;
    } catch (e) {
      NotificationsService.showSnackbarError(
          'Advertencia', 'Campos incorrectos', context);
    }
  }

  static Future Put(String path, Map<String, dynamic> data, context) async {
    final fromData = json.encode(data);

    try {
      final res = await _dio.put(path, data: fromData);

      if (res.data['result']['success'] == false) {
        AlertService.alertApiError(
            context, ApiErrorUtils.getErrors(res.data['result']));
        return null;
      }

      return res.data;
    } catch (e) {
      NotificationsService.showSnackbarError(
          'Advertencia', 'Campos incorrectos', context);
    }
  }

  static Future Get(String path, Map<String, dynamic> data, context) async {
    try {
      final res = await _dio.get(path, queryParameters: data);

      if (res.data['result']['success'] == false) {
        AlertService.alertApiError(
            context, ApiErrorUtils.getErrors(res.data['result']['result']));
        return null;
      }

      return res.data['result']['result'];
    } catch (e) {
      print(e);
      throw ("error en el get");
    }
  }

  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final resp = await _dio.delete(path, data: formData);
      return resp.data;
    } on DioError catch (e) {
      print(e);
      throw ('Error en el delete');
    }
  }
}
