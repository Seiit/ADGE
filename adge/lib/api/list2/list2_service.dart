import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/sistema/drop_down_data.dart';

class List2Service {
  static Future<List<DropDownData>?> getDropData(
      String apiConsumeDir, context, key, valor, lista) async {
    Map<String, dynamic> data = {};
    List<DropDownData> dropData = [];

    dropData.add(DropDownData('', 'Seleccione'));

    await AdgeApi.Get(apiConsumeDir, data, context).then((value) {
      for (var element in value[lista]) {
        dropData.add(DropDownData(element[key].toString(), element[valor]));
      }
    });

    return dropData;
  }
}
