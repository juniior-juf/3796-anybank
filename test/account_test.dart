import 'package:anybank/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Account account;

  setUp(() {
    account = Account(id: 123, name: "Beto", cpf: "123.123.123-22", balance: 100);
  });
  group("Account Transfer Tests", (){
    test("Deve atualizar corretamente o valor do saldo quando a transferência for válida", (){
      account.transfer(100);

      expect(account.balance, 0);
    });
    test("Deve lançar InvalidAmountExcption quando passar um valor inválido", (){
      expect(() => account.transfer(0), throwsA(isA<InvalidAmountException>()));
      expect(() => account.transfer(-100), throwsA(isA<InvalidAmountException>()));
    });
    test("Deve lançar InsuficientAmountException quando o valor de transferência for maior do que o saldo disponível", (){
      expect(() => account.transfer(101), throwsA(isA<InsuficientAmountException>()));
    });
    test("Deve lançar NullAmountException quando o valor de uma transferência for nulo", (){
      expect(() => account.transfer(null), throwsA(isA<NullAmountException>()));
    });
  });

  group("Account interest rates", (){
    test("Deve-se aplicar um juros de 1% quando o tipo de conta for conta corrente", (){
      account.applyInterest();
      expect(account.balance, 101);
    });

    test("Deve-se aplicar um juros de 3% quando o tipo de conta for conta poupança", (){
      final Account savingsAccount = Account(id: 123, name: "Beto", cpf: "123.123.123-22", balance: 100, accountType: AccountTypes.savings);

      savingsAccount.applyInterest();

      expect(savingsAccount.balance, 103);
    });

    test("Deve-se aplicar um juros de 7% quando o tipo de conta for conta investimento", (){
      final Account investmentAccount = Account(id: 123, name: "Beto", cpf: "123.123.123-22", balance: 100, accountType: AccountTypes.investment);

      investmentAccount.applyInterest();

      expect(investmentAccount.balance, 107);
    });
  });
}