// Imports
import 'package:tobe_total/src/data_base/db.dart';


class Blocks extends LocalDataBase {


  Future<bool> isWODsExist() async {
    // Check if exist any user in the database
    return await isAny('blocks');
  }

  Future<List<Map<String, Object?>>> getWODs() async {
    // Get the profile of the user.
    return getAll('blocks');
  }

  Future<List<Map<String, Object?>>> getBlocksByWodId(int wodId) async {
    // Get the profile of the user.
    return getFiltered('blocks', 'wod_id', '$wodId');
  }

}