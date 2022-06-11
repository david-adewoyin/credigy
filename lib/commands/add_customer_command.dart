import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/customer_model.dart';

class AddCustomerCommand extends BaseAppCommand {
  Future<CustomerModel> run({
    required String name,
    String? address,
    String? phone,
    String? email,
    String? desc,
  }) async {
    var c = CustomerModel(
      name: name,
      email: email,
      address: address,
      phone: phone,
      description: desc,
    );
    var res = await appService.addCustomer(c);
    c.id = res.id;
    appModel.addCustomer(c);
    return c;
  }
}

class UpdateCustomerCommand extends BaseAppCommand {
  Future<CustomerModel> run({
    required String name,
    required int id,
    String? address,
    String? phone,
    String? email,
    String? desc,
  }) async {
    var c = CustomerModel(
      id: id,
      name: name,
      email: email,
      address: address,
      phone: phone,
      description: desc,
    );
    var res = await appService.updateCustomer(c);
    appModel.updateCustomer(res);
    return res;
  }
}

class DeleteCustomerCommand extends BaseAppCommand {
  Future<bool> run(int id) async {
    try {
      var del_id = await appService.deleteCustomer(id);
      appModel.deleteCustomer(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
