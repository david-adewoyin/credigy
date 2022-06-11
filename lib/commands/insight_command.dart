import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/insight_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/services/app_service.dart';

class InsightCommand extends BaseAppCommand {
  Future<double> getTotalExpenses() async {
    var c = appService.getAllTimeTotalExpenses();
    appModel.setTotalExpense(c);
    return c;
  }

  Future<double> getTotalIncome() async {
    var c = appService.getAllTimeTotalSales();
    appModel.setTotalIncome(c);
    return c;
  }

  Future<List<InvoiceModel>> getInvoices() async {
    var inv = await appService.getInvoices();
    return inv;
  }

  Future<int> markInvoiceHasPaid(int id) async {
    return await appService.markInvoiceHasPaid(id);
  }

  Future<double> filterTotalExpenses(FilterByDate filter) async {
    var c = appService.getTotalExpenses(filter: filter);
    return c;
  }

  Future<double> filterTotalIncome(FilterByDate filter) async {
    var c = appService.getTotalSales(filter: filter);
    return c;
  }

  Future<IncomeStatement> getIncomeStatement(DateTime date) async {
    return await appService.getIncomeStatement(date);
  }

  Future<BalanceSheet> getBalanceSheet(DateTime date) async {
    return await appService.getBalanceSheet(date);
  }
}
