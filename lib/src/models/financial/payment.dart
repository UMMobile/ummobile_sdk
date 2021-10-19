/// The payment model.
class Payment {
  /// The payment reference.
  ///
  /// Format: `studentId-balanceId-timestamp`
  String reference;

  /// The payment amount.
  String amount;

  /// The expiration date for the generated URL.
  ///
  /// TODO: Set tomorrow by default and change type to DateTime. A day after today (today + 1day)
  String expirationDate;

  /// The email of the client.
  String clientMail;

  /// The additional data.
  ///
  /// Here is where the invoice data is sent.
  List<PaymentAdditionalData> additionalData;

  /// The Payment constructor.
  Payment({
    required this.reference,
    required this.amount,
    required this.expirationDate,
    required this.clientMail,
    this.additionalData: const [],
  });

  /// Returns this information in JSON format.
  Map<String, dynamic> toJson() => {
        'reference': reference,
        'amount': amount,
        'expirationDate': expirationDate,
        'clientMail': clientMail,
        'additionalData': this.additionalData.map((i) => i.toJson()).toList(),
      };
}

/// The payment additional data model.
class PaymentAdditionalData {
  /// The id for the data.
  int id;

  /// The label for the data.
  String label;

  /// The value for the data.
  String value;

  /// The PaymentAdditionalData constructor.
  PaymentAdditionalData({
    required this.id,
    required this.label,
    required this.value,
  });

  /// Returns this information in JSON format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'value': value,
      };
}
