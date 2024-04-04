import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

// class ExcelToJson {
//   Future<String?> convert() async {
//     FilePickerResult? file = await FilePicker.platform.pickFiles(
//         type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls']);
//     if (file != null && file.files.isNotEmpty) {
//       var bytes = file.files.single.bytes!;
//       var excel = Excel.decodeBytes(List.from(bytes));
//       int i = 0;
//       List<dynamic> keys = <dynamic>[];
//       List<Map<String, dynamic>> json = <Map<String, dynamic>>[];
//       for (var table in excel.tables.keys) {
//         for (var row in excel.tables[table]?.rows ?? []) {
//           try {
//             if (i == 0) {
//               keys = row;
//               i++;
//             } else {
//               Map<String, dynamic> temp = Map<String, dynamic>();
//               int j = 0;
//               String tk = '';
//               for (var key in keys) {
//                 tk = key.value;
//                 temp[tk] = (row[j].runtimeType == String)
//                     ? "\u201C" + row[j].value + "\u201D"
//                     : row[j].value;
//                 j++;
//               }
//               json.add(temp);
//             }
//           } catch (ex) {
//             Map<String, dynamic> temp = Map<String, dynamic>();
//             temp['ExcellStatus']='Error';
//             json.add(temp);
//
//
//           }
//         }
//       }
//       String fullJson = jsonEncode(json);
//
//       return fullJson;
//     }
//     return null;
//   }
// }

class ExcelToJson {
  Future<String?> convert() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['xlsx', 'csv', 'xls']);
    if (file != null && file.files.isNotEmpty) {
      var bytes = file.files.single.bytes!;
      var excel = Excel.decodeBytes(List.from(bytes));
      int i = 0;
      int inc=0;
      List<dynamic> keys = <dynamic>[];
      List<Map<String, dynamic>> json = <Map<String, dynamic>>[];
      for (var table in excel.tables.keys) {

        for (var row in excel.tables[table]?.rows ?? []) {
          try {
            if (i == 0) {
              keys = row;
              i++;
            } else {

              Map<String, dynamic> temp = Map<String, dynamic>();


              int j = 0;


              String tk = '';
              inc++;
              print(inc.toString());

              for (var key in keys) {


                tk = key.value.toString();
                // print("6");
                temp[tk] = (row[j].runtimeType == String)
                    ? "\u201C" + row[j].value + "\u201D"
                    : row[j].value.toString();
                // print("7");
                j++;
              }
              json.add(temp);
            }
          } catch (ex) {
            print("ssssssssssssssssss"+ex.toString());
            Map<String, dynamic> temp = Map<String, dynamic>();
            temp['ExcellStatus']='Error';
            json.add(temp);


          }
        }
      }
      String fullJson = jsonEncode(json).toString();

      return fullJson;
    }
    return null;
  }
}
