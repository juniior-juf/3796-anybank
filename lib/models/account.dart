// ignore_for_file: public_member_api_docs, sort_constructors_first
class NullAmountException implements Exception {
  @override
  String toString() => "O valor não pode ser nulo";
}

class InsuficientAmountException implements Exception {
  @override
  String toString() => "Saldo insuficiênte para realizar a transferência";
}

class InvalidAmountException implements Exception {
  @override
  String toString() => "O valor da transferência deve ser maior do que 0";
}

enum AccountTypes {
  checkings,
  savings,
  investment
}

class Account {
  final int id;
  final String name;
  final String cpf;
  double balance;
  final AccountTypes accountType;

  Account({
    required this.id,
    required this.name,
    required this.cpf,
    required this.balance,
    this.accountType = AccountTypes.checkings,
  });

  void transfer(double? amount) {
    if (amount == null) {
      throw NullAmountException();
    }

    if (amount > balance) {
      throw InsuficientAmountException();
    }

    if (amount <= 0) {
      throw InvalidAmountException();
    }

    balance = balance - amount;
  }

  void applyInterest() {
    double interest = 0.01;

    if (accountType == AccountTypes.savings) {
      interest = 0.03;
    }

    if (accountType == AccountTypes.investment) {
      interest = 0.07;
    }

    balance += balance * interest;
  }
}
