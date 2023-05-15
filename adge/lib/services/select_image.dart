import 'dart:html';

import 'package:flutter/foundation.dart';

void uploadImage(@required Function(File file) onSelected) {
  FileUploadInputElement uploadInput = FileUploadInputElement()
    ..accept = 'image/*';

  uploadInput.click();

  uploadInput.onChange.listen((event) {
    final file = uploadInput.files!.first;
    final reader = FileReader();

    reader.readAsDataUrl(file);
    reader.onLoadEnd.listen((event) {
      onSelected(file);
    });
  });
}
