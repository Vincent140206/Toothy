class Transaction {
  final String? orderId;
  final int? grossAmount;
  final String? paymentUrl;
  final String? snapToken;
  final String? paymentStatus;

  Transaction({
    this.orderId,
    this.grossAmount,
    this.paymentUrl,
    this.snapToken,
    this.paymentStatus,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      orderId: json["order_id"],
      grossAmount: json["gross_amount"],
      paymentUrl: json["payment_url"],
      snapToken: json["snap_token"],
      paymentStatus: json["payment_status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId,
      "gross_amount": grossAmount,
      "payment_url": paymentUrl,
      "snap_token": snapToken,
      "payment_status": paymentStatus,
    };
  }
}