import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/inventory_model.dart';

class AddInventoryCommand extends BaseAppCommand {
  Future<InventoryModel> run({
    required String productName,
    required MeasurementUnit measurementUnit,
    required double costPrice,
    int? quantity,
    required double sellingPrice,
  }) async {
    var p = InventoryModel(
      productName: productName,
      sellingPrice: sellingPrice,
      quantity: quantity,
      costPrice: costPrice,
      unit: measurementUnit,
    );
    var res = await appService.addInventory(p);
    p.id = res.id;
    appModel.addInventoryItem(p);
    return p;
  }
}

class UpdateInventoryItemCommand extends BaseAppCommand {
  Future<InventoryModel> run({
    required int id,
    required String productName,
    required MeasurementUnit measurementUnit,
    required double costPrice,
    int? quantity,
    required double sellingPrice,
  }) async {
    var p = InventoryModel(
      id: id,
      productName: productName,
      sellingPrice: sellingPrice,
      quantity: quantity,
      costPrice: costPrice,
      unit: measurementUnit,
    );
    var res = await appService.updateInventoryItem(p);
    appModel.updateProduct(res);
    print(res.sellingPrice);
    return res;
  }
}

class DeleteInventoryCommand extends BaseAppCommand {
  Future<bool> run(int id) async {
    try {
      var del_id = await appService.deleteInventoryItem(id);
      appModel.deleteInventory(id);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
