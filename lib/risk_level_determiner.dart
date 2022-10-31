import 'package:error_monitoring/enums/risk_level_enum.dart';
import 'package:error_monitoring/error_dto.dart';

abstract class IRiskLevelDeterminer {
  IRiskLevelDeterminer();

  RiskLevel determine(ErrorDto data);
}
