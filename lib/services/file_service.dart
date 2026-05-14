import 'dart:io';

import '../models/file_item_model.dart';

class FileService {

  Future<List<FileItemModel>> getFiles(String path) async {

    final directory = Directory(path);

    if (!await directory.exists()) {
      return [];
    }

    final List<FileSystemEntity> entities =
        directory.listSync();

    List<FileItemModel> items = [];

    for (var entity in entities) {

      items.add(

        FileItemModel(

          name: entity.path.split('/').last,

          path: entity.path,

          isFolder: entity is Directory,

        ),
      );
    }

    return items;
  }
}
