import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ox_sdk/ox_sdk.dart';

part 'distance.freezed.dart';


enum DistanceUnit {
  mi,
  km,
  m
}

DistanceUnit getRelevantUnitBetweenTwo(DistanceUnit u1, DistanceUnit u2) {
  if (u1 == DistanceUnit.km || u2 == DistanceUnit.km) {
    return DistanceUnit.km;
  } else if (u1 == DistanceUnit.mi || u2 == DistanceUnit.mi) {
    return DistanceUnit.mi;
  } else {
    return DistanceUnit.m;
  }
}


extension on double {
  double anyToMeter(DistanceUnit srcUnit) {
    switch (srcUnit) {
      case DistanceUnit.m:
        return this;
      case DistanceUnit.km:
        return this * 1000;
      case DistanceUnit.mi:
        return this * 1609.34;
    }
  }


  double meterToAny(DistanceUnit destUnit) {
    switch (destUnit) {
      case DistanceUnit.m:
        return this;
      case DistanceUnit.km:
        return this / 1000;
      case DistanceUnit.mi:
        return this / 1609.34;
    }
  }
}

@freezed
class Distance with _$Distance {
  const Distance._();

  factory Distance({
    required double value,
    required DistanceUnit unit
  }) = _Distance;



  Distance operator +(Distance other) {
    final thisInMeter = to(DistanceUnit.m);
    final otherInMeter = other.to(DistanceUnit.m);
    final total = thisInMeter + otherInMeter;
    final resUnit = getRelevantUnitBetweenTwo(unit, other.unit);
    return Distance(
      value: total.meterToAny(resUnit),
      unit: resUnit,
    );
  }


  double to(DistanceUnit destUnit) {
    final inMeter = value.anyToMeter(unit);
    return inMeter.meterToAny(destUnit);
  }
}



@freezed
class DistanceFieldValue with _$DistanceFieldValue {
  const DistanceFieldValue._();

  factory DistanceFieldValue.fromDistance(Distance distance) => DistanceFieldValue(
    value: distance.value,
    unit: distance.unit
  );

  factory DistanceFieldValue({
    double? value,
    DistanceUnit? unit
  }) = _DistanceFieldValue;


  bool isValid() {
    return value != null && unit != null;
  }


  Distance toDistance() {
    if (unit == null || value == null) {
      throw Exception('Invalid distance');
    }
    return Distance(
      unit: unit!,
      value: value!
    );
  }
}
