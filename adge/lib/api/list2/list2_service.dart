import 'package:adge/api/AdgeApi.dart';
import 'package:adge/models/sistema/drop_down_data.dart';

class List2Service {
  static Future<List<DropDownData>?> getDropData(
      String apiConsumeDir, context, key, value) async {
    Map<String, dynamic> data = {};
    List<DropDownData> dropData = [];

    await AdgeApi.Get(apiConsumeDir, data, context).then((value) {
      value['result'].forEach((element) {
        dropData.add(DropDownData(element[key], element[value]));
      });
    });

    return dropData;
  }
}
