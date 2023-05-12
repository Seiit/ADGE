import 'package:adge/models/sistema/api_error.dart';
import 'package:adge/services/notifications_service.dart';
import 'package:flutter/material.dart';

class AlertService {
  static alertApiError(BuildContext context, List<ApiError> errores) {
    for (ApiError error in errores) {
      NotificationsService.showSnackbarError(
          'Advertencia: ' + error.parametro, error.textoError, context);
    }
  }
}
