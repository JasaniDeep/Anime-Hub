class AiredProp {
  final int? day;
  final int? month;
  final int? year;

  AiredProp({
    this.day,
    this.month,
    this.year,
  });

  factory AiredProp.fromJson(Map<String, dynamic> json) {
    return AiredProp(
      day: json['day'] as int?,
      month: json['month'] as int?,
      year: json['year'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'month': month,
      'year': year,
    };
  }
}

class Aired {
  final String? from;
  final String? to;
  final AiredProp? propFrom;
  final AiredProp? propTo;
  final String? string;

  Aired({
    this.from,
    this.to,
    this.propFrom,
    this.propTo,
    this.string,
  });

  factory Aired.fromJson(Map<String, dynamic> json) {
    return Aired(
      from: json['from'] as String?,
      to: json['to'] as String?,
      propFrom: json['prop'] != null && json['prop']['from'] != null
          ? AiredProp.fromJson(json['prop']['from'] as Map<String, dynamic>)
          : null,
      propTo: json['prop'] != null && json['prop']['to'] != null
          ? AiredProp.fromJson(json['prop']['to'] as Map<String, dynamic>)
          : null,
      string: json['string'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
      'prop': {
        'from': propFrom?.toJson(),
        'to': propTo?.toJson(),
      },
      'string': string,
    };
  }
}

