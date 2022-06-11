import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/commands/cash_command.dart';

class AppCommand extends BaseAppCommand {
  DateTime getBusinessStartDate() {
    return appService.businessStartDate();
  }
}
