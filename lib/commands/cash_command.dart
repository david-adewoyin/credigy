import 'package:credigy/commands/app/base_command.dart';
import 'package:credigy/models/transaction_model.dart';

class AddCashCommand extends BaseAppCommand {
  run(BusinessMoneyModel money) async {
    var c = await appService.addToBusinessMoney(money);
    if (money.account == CurrentAccount.bank) {
      var b = appModel.getTotalBank();
      appModel.setTotalBank(b + money.amount);
    } else if (money.account == CurrentAccount.cash) {
      var b = appModel.getTotalCash();
      appModel.setTotalCash(b + money.amount);
    }
  }
}

class WithdrawCashCommand extends BaseAppCommand {
  run(BusinessMoneyModel money, CurrentAccount account) async {
    await appService.widthdrawBusinessMoney(money, account);
    var m = await appService.getTotalBusinessCash();
    appModel.setTotalCash(m[0]);
    appModel.setTotalBank(m[1]);
  }
}

class GetBusinessCashFlowCommand extends BaseAppCommand {
  Future<List<double>> run() async {
    return await appService.getTotalBusinessCash();
  }
}
