import 'package:unhandled_error_reporter/enums/risk_level_enum.dart';
import 'package:unhandled_error_reporter/error_dto.dart';

abstract class IRiskLevelDeterminer {
  IRiskLevelDeterminer();

  RiskLevel determine(ErrorDto data);
}
