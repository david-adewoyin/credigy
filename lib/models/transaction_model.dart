import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/inventory_model.dart';

const String _columnSaleTransactionId = "sale_transaction_id";
const String _columnPaymentType = "payment_type";
const String _columnDate = "sale_date";
const String _columnPaymentMethod = "payment_method";
const String _columnCustomerName = "customer_name";
const String _columnCustomerId = "customer_id";

const String _columnSaleRecordProductQuantity = "sale_record_product_quantity";
const String _columnSaleRecordProductId = "sale_record_product_id";
const String _columnSaleRecordProductName = "sale_record_product_name";
const String _columnSaleRecordTransactionId = "sale_record_transaction_id";
const String _columnSaleRecordProductCostPrice = "sale_record_costPrice";
const String _columnSaleRecordProductSellingPrice = "sale_record_selling_Price";

const String _columnExpenseTransactionId = "expense_transaction_id";
const String _columnExpenseName = "expense_name";
const String _columnExpenseDate = "expense_date";
const String _columnExpenseAmount = "expense_amount";
const String _columnExpensePaymentMethod = "expense_payment_method";

const String _columnPurchaseTransactionId = "purchase_transaction_id";
const String _columnPurchaseName = "purchase_name";
const String _columnPurchaseDate = "purchase_date";
const String _columnPurchaseAmount = "purchase_amount";
const String _columnPurchasePaymentMethod = "purchase_payment_method";

const String _columnCashId = "column_cash_id";
const String _columnCashAmount = "cash_ammount";
const String _columnCashType = "cash_type";
const String _columnCashDate = "column_cash_date";
const String _columnCashBusinessActionType = "cash_buss_action_type";

const String _columnInvoiceId = "column_invoice_id";
const String _columnInvoiceDate = "column_invoice_date";
const String _columnInvoiceStatus = "column_invoice_status";

enum PaymentType { full, credit }

enum PaymentMethod { cash, bank }

enum FilterByDate {
  today,
  week,
  allTime,
}

enum ExpenseType {
  procurementCost,
  wages,
  rent,
  utilities,
  transportation,
  bills,
  others,
}

extension Name on ExpenseType {
  String displayName() {
    switch (this) {
      case ExpenseType.bills:
        return "Bills";
      case ExpenseType.procurementCost:
        return "Procurement Cost";
      case ExpenseType.rent:
        return "Rent";
      case ExpenseType.transportation:
        return "Transportation";
      case ExpenseType.utilities:
        return "Utilities";
      case ExpenseType.wages:
        return "Wages";
      case ExpenseType.others:
        return "Others";
    }
  }
}

class ProductTransactionModel {
  String name;
  int? saleId;
  int id;
  int? quantity;
  double sellingPrice;
  double costPrice;
  ProductTransactionModel(
      {required this.name,
      required this.id,
      this.saleId,
      this.quantity,
      required this.sellingPrice,
      required this.costPrice});
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnSaleRecordProductId: id,
      _columnSaleRecordTransactionId: saleId,
      _columnSaleRecordProductName: name,
      _columnSaleRecordProductQuantity: quantity,
      _columnSaleRecordProductCostPrice: costPrice,
      _columnSaleRecordProductSellingPrice: sellingPrice,
    };
    return map;
  }
}

class SalesTransactionModel {
  int? id;
  PaymentMethod paymentMethod;
  PaymentType paymentType;
  DateTime date;
  List<ProductTransactionModel> products;
  CustomerModel customer;
  double totalAmount;
  SalesTransactionModel({
    this.id,
    required this.date,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentType,
    required this.products,
    required this.customer,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnSaleTransactionId: id,
      _columnPaymentType: paymentType.toString(),
      _columnCustomerId: customer.id,
      _columnPaymentMethod: paymentMethod.toString(),
      _columnDate: date.toString(),
    };
    return map;
  }
}

class ExpenseTransactionModel {
  int? id;
  ExpenseType expenseDesc;
  DateTime date;
  double amount;
  PaymentMethod account;

  ExpenseTransactionModel({
    required this.expenseDesc,
    this.id,
    required this.date,
    required this.account,
    required this.amount,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnExpenseTransactionId: id,
      _columnExpenseName: expenseDesc.toString(),
      _columnExpensePaymentMethod: account.toString(),
      _columnExpenseDate: date.toString(),
      _columnExpenseAmount: amount,
    };
    return map;
  }
}

class PurchaseTransactionModel {
  int? id;
  String purchaseName;
  DateTime date;
  double amount;
  PaymentMethod account;

  PurchaseTransactionModel({
    required this.purchaseName,
    this.id,
    required this.date,
    required this.account,
    required this.amount,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnPurchaseTransactionId: id,
      _columnPurchaseName: purchaseName,
      _columnPurchasePaymentMethod: account.toString(),
      _columnPurchaseDate: date.toString(),
      _columnPurchaseAmount: amount,
    };
    return map;
  }
}

enum TransactionModelType {
  sale,
  purchase,
  expense,
}

class TransactionModel {
  int id;
  String transactionName;
  TransactionModelType transactionType;
  double amount;
  DateTime dateTime;
  PaymentMethod account;
  TransactionModel({
    required this.amount,
    required this.dateTime,
    required this.id,
    required this.account,
    required this.transactionName,
    required this.transactionType,
  });
}

enum BusinessMoneyModelType { withdraw, add }

enum CurrentAccount { cash, bank }

class BusinessMoneyModel {
  int? id;
  double amount;
  DateTime date;
  CurrentAccount account;
  BusinessMoneyModelType actionType;
  BusinessMoneyModel({
    required this.amount,
    this.id,
    required this.date,
    required this.account,
    required this.actionType,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnCashId: id,
      _columnCashAmount: amount,
      _columnCashType: account.toString(),
      _columnCashBusinessActionType: actionType.toString(),
      _columnCashDate: date.toString(),
    };
    return map;
  }
}

enum InvoiceStatus { paid, unpaid }

extension InvoiceName on InvoiceStatus {
  String displayName() {
    switch (this) {
      case InvoiceStatus.paid:
        return "Paid";
      case InvoiceStatus.unpaid:
        return "Unpaid";
    }
  }
}

class InvoiceModel {
  int? id;
  SalesTransactionModel sale;
  DateTime date;
  CustomerModel customer;
  InvoiceStatus status;
  InvoiceModel(
      {this.id,
      required this.sale,
      required this.date,
      required this.status,
      required this.customer});
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnInvoiceId: id,
      _columnSaleTransactionId: sale.id,
      _columnInvoiceDate: date.toString(),
      _columnInvoiceStatus: status.toString(),
    };
    return map;
  }
}
