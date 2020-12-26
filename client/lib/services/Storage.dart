import 'dart:io';
import 'dart:convert';
import "package:path_provider/path_provider.dart";

class Storage {
  static _InternalStorage _storage;

  static Future<_InternalStorage> getStorage() async {
    if (_storage == null) {
      _storage = new _InternalStorage();
      await _storage._initialize();
      return _storage;
    } else {
      return _storage;
    }
  }
}

class _InternalStorage {
  File _metadataFile;
  String _id;

  Future<void> _initialize() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath = appDirectory.path + "/metadata.json";

    if (!File(filePath).existsSync()) {
      File(filePath).createSync();
    }

    this._metadataFile = File(filePath);
    String fileData = this._metadataFile.readAsStringSync();
    if (fileData != "") {
      Map<String, dynamic> metadata = json.decode(fileData);
      if (metadata.containsKey("id")) {
        this._id = metadata["id"];
      }
    }
  }

  bool isEmpty() {
    return this._id == null;
  }

  String getId() {
    return this._id;
  }

  Future<void> setId(String id) async {
    this._id = id;
    Map<String, String> idMap = {"id":this._id};
    await this._metadataFile.writeAsString(json.encode(idMap));
  }
}
