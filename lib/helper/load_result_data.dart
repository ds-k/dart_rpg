import 'dart:io';

Future<List<List<dynamic>>?> loadResultData() async {
  try {
    final file = File('assets/db/result.csv');
    final lines = await file.readAsLines();
    if (lines.isEmpty) throw Exception("기록이 없습니다!");
    List<List<dynamic>> results = [];
    for (String line in lines) {
      List<dynamic> lineList = line.split(",");
      results.add([lineList[0], lineList[1], lineList[2]]);
    }
    return results;
  } catch (e) {
    return null;
  }
}
