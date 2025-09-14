import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:toothy/core/constants/url.dart';
import 'package:toothy/core/services/dio_client.dart';

class MidTransService {
  final DioClient dioClient = DioClient();
  final Urls urls = Urls();
  MidtransSDK? _midtrans;

  Future<void> initMidtrans() async {
    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: "SB-Mid-client-ohIe6VgGelz6UgEu",
        merchantBaseUrl: "urls bang merchant",
      ),
    );

    _midtrans?.setTransactionFinishedCallback((result) {
      print("Result: $result");
      print("Result.status: ${result.status}");
    });


  }

  Future<String> getSnapToken() async {
    final response = await dioClient.dio.post(
      "urls.snapTokenEndpoint",
      data: {
        "order_id": "ORDER-${DateTime.now().millisecondsSinceEpoch}",
        "gross_amount": 100000,
        "name": "Nama User",
        "email": "user@email.com",
        "phone": "08123456789",
      },
    );

    return response.data['token'];
  }

  Future<void> pay(String snapToken) async {
    if (_midtrans == null) {
      await initMidtrans();
    }

    await _midtrans?.startPaymentUiFlow(
      token: snapToken,
    );
  }
}
