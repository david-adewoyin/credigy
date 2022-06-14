import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/transaction_model.dart';

class AddSalesTransactionCommand extends BaseAppCommand {
  Future<SalesTransactionModel> run(
      {required SalesTransactionModel saleModel,
      required CustomerModel customer}) async {
    var sale = await appService.addSaleTransaction(saleModel);
    for (var e in sale.products) {
      if (e.quantity != null) {
        await appService.updateInventoryItemQuantity(e.name, e.quantity!);
      }
    }
    if (sale.paymentType == PaymentType.credit) {
      var inv = InvoiceModel(
        sale: sale,
        date: sale.date,
        status: InvoiceStatus.unpaid,
        customer: customer,
      );
      await appService.insertInvoice(inv);
    }

    double totalAmount = 0;
    double totalIncome = 0;
    for (var p in sale.products) {
      if (p.quantity != null) {
        double q = 1.0 * p.quantity! * 1.0;
        double a = (q * p.sellingPrice);
        double i = (q * p.sellingPrice) - (p.costPrice * p.quantity!);

        totalAmount = totalAmount + a;
        totalIncome = totalIncome + i;
      } else {
        totalAmount = totalAmount + p.sellingPrice;
        totalIncome = totalIncome + p.sellingPrice - p.costPrice;
      }
    }
    print(totalAmount);
    print(totalIncome);
    CurrentAccount account;
    if (saleModel.paymentMethod == PaymentMethod.bank) {
      account = CurrentAccount.bank;
    } else {
      account = CurrentAccount.cash;
    }
    var newTotal = await appService.addToCurrentAccount(account, totalAmount);
    var c = await appService.getTotalBusinessCash();
    if (account == CurrentAccount.bank) {
      appModel.setTotalBank(c[1]);
    } else {
      print("total cash is ${c[0]}");
      appModel.setTotalCash(c[0]);
    }

    var total = await appService.addToTotalIncome(totalIncome);
    appModel.setTotalIncome(total);
    var d = sale.id;
    var s = TransactionModel(
        amount: totalAmount,
        dateTime: sale.date,
        id: sale.id!,
        account: sale.paymentMethod,
        transactionName: "Sales # $d",
        transactionType: TransactionModelType.sale);

    var ser = await appService.getAllInventory();
    await appModel.populateInventory(ser);
    appModel.setTotalIncome(total);
    appModel.addTransaction(s);
    return sale;
  }
}

class AddExpenseTransactionCommand extends BaseAppCommand {
  Future<ExpenseTransactionModel> run(
      {required ExpenseTransactionModel expense}) async {
    var exp = await appService.addExpenseTransaction(expense);
    CurrentAccount account;
    if (exp.account == PaymentMethod.bank) {
      account = CurrentAccount.bank;
    } else {
      account = CurrentAccount.cash;
    }
    var newTotal = await appService.payForExpense(account, expense.amount);
    if (account == CurrentAccount.bank) {
      appModel.setTotalBank(newTotal);
    } else {
      appModel.setTotalCash(newTotal);
    }
    var e = TransactionModel(
        amount: exp.amount,
        dateTime: exp.date,
        id: exp.id!,
        account: exp.account,
        transactionName: exp.expenseDesc.displayName(),
        transactionType: TransactionModelType.expense);
    var total = await appService.addToTotalExpense(exp.amount);
    appModel.setTotalExpense(total);
    appModel.addTransaction(e);
    return exp;
  }
}

class AddPurchaseTransactionCommand extends BaseAppCommand {
  Future<PurchaseTransactionModel> run(
      {required PurchaseTransactionModel purchase}) async {
    var pur = await appService.addPurchaseTransaction(purchase);
    var p = TransactionModel(
        amount: pur.amount,
        dateTime: pur.date,
        id: pur.id!,
        account: pur.account,
        transactionName: pur.purchaseName,
        transactionType: TransactionModelType.purchase);
    var total = await appService.addToTotalExpense(pur.amount);
    appModel.setTotalExpense(total);
    appModel.addTransaction(p);
    return pur;
  }
}
