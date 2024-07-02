class SqlGenerator {
  ///
  static String Insert(String tableName, Map<String, dynamic> values) {
    if (values.isEmpty) {
      throw ArgumentError('Values cannot be empty');
    }

    String columns = values.keys.join(', ');
    String valuesClause = values.values.map((value) {
      return value is String ? "'$value'" : value.toString();
    }).join(', ');

    return 'INSERT INTO $tableName ($columns) VALUES ($valuesClause)';
  }

  ///
  static String Update(String tableName, Map<String, dynamic> values, Map<String, dynamic> where) {
    if (values.isEmpty || where.isEmpty) {
      throw ArgumentError('Values and where clauses cannot be empty');
    }

    String setClause = values.entries.map((e) {
      String value = e.value is String ? "'${e.value}'" : e.value.toString();
      return '${e.key} = $value';
    }).join(', ');

    String whereClause = where.entries.map((e) {
      String value = e.value is String ? "'${e.value}'" : e.value.toString();
      return '${e.key} = $value';
    }).join(' AND ');

    return 'UPDATE $tableName SET $setClause WHERE $whereClause';
  }

  ///
  static String Delete(String tableName, Map<String, dynamic> where) {
    if (where.isEmpty) {
      throw ArgumentError('Where clause cannot be empty');
    }

    String whereClause = where.entries.map((e) {
      String value = e.value is String ? "'${e.value}'" : e.value.toString();
      return '${e.key} = $value';
    }).join(' AND ');

    return 'DELETE FROM $tableName WHERE $whereClause';
  }

  ///
  static String Select(String tableName, List<String> columns, Map<String, dynamic> where) {
    String columnsClause = columns.isNotEmpty ? columns.join(', ') : '*';
    String whereClause = '';
    if (where.isNotEmpty) {
      whereClause = 'WHERE ${where.entries.map((e) {
        String value = e.value is String ? "'${e.value}'" : e.value.toString();
        return '${e.key} = $value';
      }).join(' AND ')}';
    }

    return 'SELECT $columnsClause FROM $tableName $whereClause';
  }
}
