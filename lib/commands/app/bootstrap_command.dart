import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/supplier_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/models/user_business_model.dart';
import 'package:flutter/material.dart';

bool _appIsBootstrapped = false;

class BootstrapCommand extends BaseAppCommand {
  static done() {
    return _appIsBootstrapped;
  }

  static Stream<bool> poolIsBoosted() {
    return Stream.periodic(Duration(milliseconds: 100), (value) {
      return _appIsBootstrapped;
    });
  }

  Future<void> run(BuildContext context) async {
    if (hasContext == false) {
      setContext(context);
    }

    await appService.init();
    bool fresh = appService.isAppFreshInstall();
    appModel.setIsFreshInstall(fresh);
    var customers = await appService.getAllCustomers();
    appModel.populateCustomer(customers);

    if (!appModel.isFreshInstall()) {
      var user = appService.getBusinessName();
      appModel.setBusinessUser(user);
      var f = await Future.wait([
        appService.getAllInventory(),
        appService.getAllSuppliers(),
        appService.transactions(),
        appService.getTotalBusinessCash(),
      ]);
      var products = f[0] as List<InventoryModel>;
      var suppliers = f[1] as List<SupplierModel>;
      var transactions = f[2] as List<TransactionModel>;
      List<double> businnessCash = f[3] as List<double>;
      appModel.populateSuppliers(suppliers);
      appModel.populateTransactions(transactions);
      appModel.populateInventory(products);
      appModel.setTotalExpense(appService.getAllTimeTotalExpenses());
      appModel.setTotalIncome(appService.getAllTimeTotalSales());
      appModel.setTotalCash(businnessCash[0]);
      appModel.setTotalBank(businnessCash[1]);
    }
    _appIsBootstrapped = true;
  }
}
