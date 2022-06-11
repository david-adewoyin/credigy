import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/supplier_model.dart';

class AddSupplierCommand extends BaseAppCommand {
  Future<SupplierModel> run({
    required String name,
    String? address,
    String? phone,
    String? email,
    String? desc,
  }) async {
    var c = SupplierModel(
      name: name,
      email: email,
      address: address,
      phone: phone,
      description: desc,
    );
    var res = await appService.addSupplier(c);
    appModel.addSupplier(res);
    return res;
  }
}

class UpdateSupplierCommand extends BaseAppCommand {
  Future<SupplierModel> run({
    required String name,
    required int id,
    String? address,
    String? phone,
    String? email,
    String? desc,
  }) async {
    var c = SupplierModel(
      id: id,
      name: name,
      email: email,
      address: address,
      phone: phone,
      description: desc,
    );
    var res = await appService.updateSupplier(c);
    appModel.updateSupplier(res);
    return res;
  }
}

class DeleteSupplierCommand extends BaseAppCommand {
  Future<bool> run(int id) async {
    try {
      var del_id = await appService.deleteSupplier(id);
      appModel.deleteSupplier(id);
      return true;
    } catch (e) {
      return false;
    }
  }
}
