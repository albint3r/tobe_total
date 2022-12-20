// Imports
import 'package:tobe_total/src/data_base/db.dart';


class WODs extends LocalDataBase {


  Future<bool> isWODsExist() async {
    // Check if exist any user in the database
    return await isAny('wods');
  }

  Future<List<Map<String, Object?>>> getWODs() async {
    // Get the profile of the user.
    return getAll('wods');
  }

}