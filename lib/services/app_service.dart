// ignore_for_file: avoid_print

import 'package:credigy/commands/add_customer_command.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/insight_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/supplier_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/models/user_business_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:credigy/services/offline.dart';

const _isFreshInstall = "isFreshInstall";

const _businessName = "businessName";
const _businessCash = "business_cash";
const _businessBank = "business_bank";
const _businessPhone = "business_phone";
const _businessEmail = "business_email";
const _businessAddress = "business_address";
const _businessStartDate = "business_start_date";

const _allTimeExpenses = "all_time_expenses";
const _allTimeSales = "all_time_sales";

class AppService {
  late SharedPreferences prefs;
  late DbProvider db;
  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();

    db = DbProvider();
    await db.initDb();
  }

  bool isAppFreshInstall() {
    bool? isFresh = prefs.getBool(_isFreshInstall);
    if (isFresh == null) return true;
    return isFresh;
  }

  UserBusinessModel getBusinessName() {
    var name = prefs.getString(_businessName)!;
    var email = prefs.getString(_businessEmail)!;
    var add = prefs.getString(_businessAddress)!;
    var phone = prefs.getString(_businessPhone)!;

    var b = UserBusinessModel(
        businessName: name, businessAddress: add, email: email, phone: phone);
    return b;
  }

  registerBusiness(UserBusinessModel b) async {
    try {
      await prefs.setString(_businessName, b.businessName);
      await prefs.setString(_businessEmail, b.email);
      await prefs.setString(_businessAddress, b.businessAddress);
      await prefs.setString(_businessPhone, b.phone);
      var today = DateTime.now().toString();
      await prefs.setString(_businessStartDate, today);

      return;
    } catch (e) {
      print("Unable to register business");
    }
  }

  DateTime businessStartDate() {
    var date = prefs.getString(_businessStartDate)!;
    return DateTime.parse(date);
  }

  setUserOnboarded() async {
    try {
      await prefs.setBool(_isFreshInstall, false);
      await prefs.setDouble(_allTimeExpenses, 0);
      await prefs.setDouble(_allTimeSales, 0);
    } catch (e) {
      print("unable to set fresh install");
    }
  }

  Future<double> getTotalExpenses({required FilterByDate filter}) async {
    switch (filter) {
      case FilterByDate.allTime:
        return getAllTimeTotalExpenses();
      case FilterByDate.today:
        var c = await db.getAllExpenseTransaction();
        var e = await db.getAllPurchasesTransaction();
        var list = c
            .where((element) =>
                element.date.difference(DateTime.now()).inHours <= 24)
            .toList();
        var listP = e
            .where((element) =>
                element.date.difference(DateTime.now()).inHours <= 24)
            .toList();
        double total = 0;
        for (var e in list) {
          total = total + e.amount;
        }
        for (var e in listP) {
          total = total + e.amount;
        }
        return total;
      case FilterByDate.week:
        var c = await db.getAllExpenseTransaction();
        var e = await db.getAllPurchasesTransaction();
        var list = c
            .where((element) =>
                element.date.difference(DateTime.now()).inDays <= 7)
            .toList();
        var listP = e
            .where((element) =>
                element.date.difference(DateTime.now()).inHours <= 7)
            .toList();
        double total = 0;
        for (var e in list) {
          total = total + e.amount;
        }
        for (var e in listP) {
          total = total + e.amount;
        }
        return total;
    }
  }

  Future<double> getTotalSales({required FilterByDate filter}) async {
    switch (filter) {
      case FilterByDate.allTime:
        return getAllTimeTotalSales();
      case FilterByDate.today:
        var c = await db.getSalesTransaction();
        var list = c
            .where((element) =>
                element.date.difference(DateTime.now()).inHours <= 24)
            .toList();
        double total = 0;
        for (var sale in list) {
          double totalAmount = 0;
          for (var p in sale.products) {
            if (p.quantity != null) {
              double a = (p.quantity! * p.sellingPrice) - p.costPrice;
              totalAmount = totalAmount + a;
            } else {
              totalAmount = totalAmount + p.sellingPrice - p.costPrice;
            }
          }
          total = total + totalAmount;
        }
        return total;
      default:
        var c = await db.getSalesTransaction();
        var list = c
            .where((element) =>
                element.date.difference(DateTime.now()).inDays <= 7)
            .toList();
        double total = 0;
        for (var sale in list) {
          double totalAmount = 0;
          for (var p in sale.products) {
            if (p.quantity != null) {
              double a = (p.quantity! * p.sellingPrice) - p.costPrice;
              totalAmount = totalAmount + a;
            } else {
              totalAmount = totalAmount + p.sellingPrice - p.costPrice;
            }
          }
          total = total + totalAmount;
        }
        return total;
    }
  }

  Future<double> addToTotalIncome(double value) async {
    var t = prefs.getDouble(_allTimeSales)!;
    var total = t + value;
    prefs.setDouble(_allTimeSales, total);
    return total;
  }

  Future<double> addToTotalExpense(double value) async {
    var t = prefs.getDouble(_allTimeExpenses)!;
    var total = t + value;
    prefs.setDouble(_allTimeExpenses, total);
    return total;
  }

  double getAllTimeTotalSales() {
    return prefs.getDouble(_allTimeSales)!;
  }

  double getAllTimeTotalExpenses() {
    return prefs.getDouble(_allTimeExpenses)!;
  }

  Future<List<InventoryModel>> getAllInventory() {
    return db.getAllProducts();
  }

  Future<InventoryModel?> getInventory(int id) {
    return db.getProduct(id);
  }

  Future<InventoryModel> addInventory(InventoryModel product) {
    return db.insertProduct(product);
  }

  Future<InventoryModel> updateInventoryItem(InventoryModel product) {
    return db.updateProduct(product);
  }

  Future<int> deleteInventoryItem(int id) {
    return db.deleteInventoryItem(id);
  }

  Future<List<CustomerModel>> getAllCustomers() {
    return db.getAllCustomer();
  }

  Future<CustomerModel> addCustomer(CustomerModel customer) {
    return db.insertCustomer(customer);
  }

  Future<CustomerModel> updateCustomer(CustomerModel customer) {
    return db.updateCustomer(customer);
  }

  Future<int> deleteCustomer(int id) {
    return db.deleteCustomer(id);
  }

  Future<List<SupplierModel>> getAllSuppliers() {
    return db.getAllSuppliers();
  }

  Future<SupplierModel> addSupplier(SupplierModel supplier) {
    return db.insertSupplier(supplier);
  }

  Future<SupplierModel> updateSupplier(SupplierModel supplier) {
    return db.updateSupplier(supplier);
  }

  Future<int> deleteSupplier(int id) {
    return db.deleteSupplier(id);
  }

  Future<int> updateInventoryItemQuantity(String productName, int quantity) {
    return db.updateProductQuantity(productName, quantity);
  }

  Future<SalesTransactionModel> addSaleTransaction(
      SalesTransactionModel sale) async {
    var s = await db.insertSaleTransaction(sale);
    var amount = sale.totalAmount;
    CurrentAccount account;
    if (sale.paymentMethod == PaymentMethod.bank) {
      account = CurrentAccount.bank;
    } else {
      account = CurrentAccount.cash;
    }
    await addToBusinessMoney(BusinessMoneyModel(
        amount: amount,
        date: DateTime.now(),
        account: account,
        actionType: BusinessMoneyModelType.add));
    return s;
  }

  Future<List<SalesTransactionModel>> allSaleTransactions() {
    return db.getSalesTransaction();
  }

  Future<List<ExpenseTransactionModel>> allExpenseTransactions() {
    return db.getAllExpenseTransaction();
  }

  Future<List<PurchaseTransactionModel>> allPurchasesTransactions() {
    return db.getAllPurchasesTransaction();
  }

  Future<List<TransactionModel>> transactions() async {
    var futures = await Future.wait([
      allSaleTransactions(),
      allExpenseTransactions(),
      allPurchasesTransactions(),
    ]);
    List<TransactionModel> transactions = [];

    List<SalesTransactionModel> sales =
        futures[0] as List<SalesTransactionModel>;
    List<ExpenseTransactionModel> expenses =
        futures[1] as List<ExpenseTransactionModel>;
    List<PurchaseTransactionModel> purchases =
        futures[2] as List<PurchaseTransactionModel>;

    for (var pur in purchases) {
      var p = TransactionModel(
          amount: pur.amount,
          dateTime: pur.date,
          id: pur.id!,
          account: pur.account,
          transactionName: pur.purchaseName,
          transactionType: TransactionModelType.purchase);
      transactions.add(p);
    }

    for (var exp in expenses) {
      var e = TransactionModel(
          amount: exp.amount,
          dateTime: exp.date,
          id: exp.id!,
          account: exp.account,
          transactionName: exp.expenseDesc.displayName(),
          transactionType: TransactionModelType.expense);
      transactions.add(e);
    }

    for (var sale in sales) {
      double totalAmount = 0;

      for (var p in sale.products) {
        //    print(p.id);
        if (p.quantity != null) {
          double a = p.quantity! * p.sellingPrice;
          totalAmount = totalAmount + a;
        } else {
          totalAmount = totalAmount + p.sellingPrice;
        }
      }
      //   print(totalAmount);
      int? id = sale.id;
      var s = TransactionModel(
          amount: totalAmount,
          dateTime: sale.date,
          id: sale.id!,
          account: sale.paymentMethod,
          transactionName: "Sales  #$id",
          transactionType: TransactionModelType.sale);
      transactions.add(s);
    }

    return transactions;
  }

  Future<ExpenseTransactionModel> addExpenseTransaction(
      ExpenseTransactionModel exp) {
    return db.insertExpenseTransaction(exp);
  }

  Future<PurchaseTransactionModel> addPurchaseTransaction(
      PurchaseTransactionModel pur) {
    return db.insertPurchaseTransaction(pur);
  }

  Future<List<InvoiceModel>> getInvoices() async {
    return await db.getAllInvoices();
  }

  Future<InvoiceModel> insertInvoice(InvoiceModel inv) async {
    return await db.insertInvoice(inv);
  }

  Future<int> markInvoiceHasPaid(int id) async {
    return await db.markInvoiceHasPaid(id);
  }

  Future<IncomeStatement> getIncomeStatement(DateTime date) async {
    List<ExpenseStatementItem> expItems = [];
    var totalSale = 0.0;

    //fetch data from past 3day;
    List<TransactionModel> trans = await this.transactions();
    var transactions = trans.where(
      (el) => el.dateTime.month == date.month && el.dateTime.year == date.year,
    );
    for (var trans in transactions) {
      if (trans.transactionType == TransactionModelType.sale) {
        totalSale = totalSale + trans.amount;
        continue;
      }
      if (trans.transactionType == TransactionModelType.expense) {
        var c = expItems
            .indexWhere((el) => el.expenseDescription == trans.transactionName);
        if (c == -1) {
          expItems.add(
            ExpenseStatementItem(
                amount: trans.amount,
                expenseDescription: trans.transactionName),
          );
          continue;
        }
        expItems[c].amount = expItems[c].amount + trans.amount;
      }
    }
    return IncomeStatement(
        saleAndService: totalSale,
        expenseStatement: ExpenseStatement(items: expItems));
  }

  Future<BalanceSheet> getBalanceSheet(DateTime date) async {
    double cashAccount = 0;
    double bankAccount = 0;
    double totalInventory = 0;
    //double accountPayable;
    var future = await Future.wait([this.transactions(), getAllInventory()]);
    List<TransactionModel> tran = future[0] as List<TransactionModel>;
    List<InventoryModel> inventory = future[1] as List<InventoryModel>;
    var transactions = tran.where((el) =>
        el.dateTime.month == date.month && el.dateTime.year == date.year);

    for (var trans in transactions) {
      if (trans.transactionType == TransactionModelType.sale) {
        if (trans.account == PaymentMethod.bank) {
          bankAccount = bankAccount + trans.amount;
          continue;
        }
        if (trans.account == PaymentMethod.cash) {
          cashAccount = cashAccount + trans.amount;
          continue;
        }
      }
    }
    for (var prods in inventory) {
      if (prods.quantity == null) {
        totalInventory = totalInventory + prods.sellingPrice;
        continue;
      }

      var total = prods.quantity! * prods.sellingPrice;
      totalInventory = totalInventory + total;
    }
    return BalanceSheet(
      bankAccount: bankAccount,
      cashAccount: cashAccount,
      totalInventory: totalInventory,
    );
  }

  Future<BusinessMoneyModel> addToBusinessMoney(
      BusinessMoneyModel money) async {
    return await db.insertMoneyIntoBusiness(money);
  }

  Future<BusinessMoneyModel> widthdrawBusinessMoney(
      BusinessMoneyModel money, CurrentAccount account) async {
    return await db.convertMoneyInBusiness(money, account);
  }

  Future<double> payForExpense(CurrentAccount account, double amount) async {
    return await db.payForExpense(account, amount);
  }

  Future<List<double>> getTotalBusinessCash() async {
    return await db.getBusinessTotalCash();
  }

  Future<double> addToCurrentAccount(
      CurrentAccount account, double amount) async {
    return db.addToCurrentAccount(account, amount);
  }
}

class BalanceSheet {
  double cashAccount;
  double bankAccount;
  double totalInventory;
  double? accountPayable;
  BalanceSheet({
    required this.bankAccount,
    required this.cashAccount,
    required this.totalInventory,
    this.accountPayable,
  });
}
