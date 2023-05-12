import 'package:adge/models/sistema/api_error.dart';

class ApiErrorUtils {
  static List<ApiError> getErrors(List<dynamic> apiErrores) {
    List<ApiError> errores = [];

    apiErrores.forEach((error) {
      ApiError errorTmp = ApiError();

      errorTmp.autonumerado = error['autonumerado'];
      errorTmp.proceso = error['proceso'];
      errorTmp.subproceso = error['subproceso'];
      errorTmp.parametro = error['parametro'];
      errorTmp.textoError = error['textoError'];
      errorTmp.tipoError = error['tipoError'];

      errores.add(errorTmp);
    });

    return errores;
  }
}
