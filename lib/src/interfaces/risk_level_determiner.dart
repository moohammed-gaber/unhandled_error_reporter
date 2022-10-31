import 'package:unhandled_error_reporter/src/enums/risk_level_enum.dart';
import 'package:unhandled_error_reporter/src/dtos/error_dto.dart';

abstract class IRiskLevelDeterminer {
  IRiskLevelDeterminer();

  RiskLevel determine(ErrorDto data);
}
