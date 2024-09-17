import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathprovider;


class HiveService {
  static var box;

  static initHive() async {
    var dir = await pathprovider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('appData');
  }

  /// User ID
  static setUserID(String id) {
    box.put('id', id);
  }

  static deleteUserID() {
    box.delete('id');
  }

  static  getUserID() async {
    return await box.get('id');
  }


}
