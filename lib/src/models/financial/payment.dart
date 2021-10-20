/// The payment model.
class Payment {
  /// The payment reference.
  ///
  /// Format: `studentId-balanceId-timestamp`
  String reference;

  /// The payment amount.
  double amount;

  /// The expiration date for the generated URL.
  DateTime expirationDate;

  /// The email of the client.
  String clientMail;

  /// The additional data.
  ///
  /// Here is where the invoice data is sent.
  List<PaymentAdditionalData> additionalData;

  /// The Payment constructor.
  ///
  /// The default value for the [expirationDate] is one day after current day: `Date.now().add(Duration(days: 1))`.
  Payment({
    required this.reference,
    required this.amount,
    required this.clientMail,
    this.additionalData: const [],
    DateTime? expirationDate,
  }) : this.expirationDate =
            expirationDate ?? DateTime.now().add(Duration(days: 1));

  /// Returns this information in JSON format.
  Map<String, dynamic> toJson() => {
        'reference': this.reference,
        'amount': this.amount,
        'expirationDate': this.expirationDate.toIso8601String(),
        'clientMail': this.clientMail,
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
        'id': this.id,
        'label': this.label,
        'value': this.value,
      };
}
