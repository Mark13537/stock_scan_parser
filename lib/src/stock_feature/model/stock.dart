class VariableValue {
  late String type;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;
  List<double?>? values;

  VariableValue({
    required this.type,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
    this.values,
  });
  VariableValue.fromJson(Map<String, dynamic> json) {
    type = json['type'].toString();
    studyType = json['study_type']?.toString();
    parameterName = json['parameter_name']?.toString();
    minValue = int.tryParse(json['min_value']?.toString() ?? '');
    maxValue = int.tryParse(json['max_value']?.toString() ?? '');
    defaultValue = int.tryParse(json['default_value']?.toString() ?? '');
    if (json['values'] != null && (json['values'] is List)) {
      final v = json['values'] as List<dynamic>;
      final arr0 = <double>[];
      for (var v in v) {
        arr0.add(double.tryParse(v.toString())!);
      }
      values = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['type'] = type;
    data['study_type'] = studyType;
    data['parameter_name'] = parameterName;
    data['min_value'] = minValue;
    data['max_value'] = maxValue;
    data['default_value'] = defaultValue;
    if (values != null) {
      final v = values;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v);
      }
      data['values'] = arr0;
    }
    return data;
  }
}

class Criteria {
  String type;
  String text;
  Map<String, VariableValue>? variable;

  Criteria({
    required this.type,
    required this.text,
    this.variable,
  });

  factory Criteria.fromJson(Map<String, dynamic> json) {
    final variableMap = json['variable'] != null
        ? json['variable'] as Map<String, dynamic>
        : null;

    Map<String, VariableValue> tempMap = {};
    if (variableMap != null) {
      for (var key in variableMap.keys.toList()) {
        tempMap[key] =
            VariableValue.fromJson(variableMap[key] as Map<String, dynamic>);
      }
    }
    return Criteria(
      type: json['type']?.toString() ?? '',
      text: json['text']?.toString() ?? '',
      variable: json['variable'] == null ? null : tempMap,
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'text': text,
        'variable': variable,
      };
}

class Stock {
  int? id;
  String name;
  String tag;
  String color;
  List<Criteria> criteria;

  Stock({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    final criteriaMap = json['criteria'] as Iterable<dynamic>;
    return Stock(
      id: int.tryParse(json['id']?.toString() ?? ''),
      name: json['name']?.toString() ?? '',
      tag: json['tag']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      criteria: List<Criteria>.from(
          criteriaMap.map((x) => Criteria.fromJson(x as Map<String, dynamic>))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tag': tag,
        'color': color,
        'criteria': List<dynamic>.from(criteria.map((x) => x.toJson())),
      };
}
