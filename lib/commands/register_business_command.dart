import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/user_business_model.dart';

class RegisterBusinessCommand extends BaseAppCommand {
  run({
    required String businessName,
    required String phone,
    required String email,
    required String address,
    /*  required double cash,
    required double bank, */
  }) async {
    var bus = UserBusinessModel(
      businessName: businessName,
      phone: phone,
      businessAddress: address,
      email: email,
    );
    await appService.registerBusiness(bus);
    await appModel.setBusinessUser(bus);
    appService.setUserOnboarded();
  }
}
