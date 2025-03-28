import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  final String _username = 'cavlogenoia@gmail.com';
  final String _password = 'ayjl rukr sjam ucxs';

  Future<bool> sendAcceptEmail(String recipientEmail, String barberName,String ventureName, String uid) async {
    final smtpServer = gmail(_username, _password);

    final message = Message()
      ..from = Address(_username, "Cavalog Official")
      ..recipients.add(recipientEmail)
      ..subject =
          "Congratulations on Successful Verification - ${DateTime.now()}"
      ..text = """
         Hello Champion!
         Welcome to Cavalog - your gateway to a seamless experience!
         Here's your UID: $uid
        """
      ..html = """
  <h1><strong style="color: orange;">Team Cavalog</strong></h1>
  <p><strong style="font-weight: bold;">Hello $barberName,</strong></p>
  <p>Welcome to Cavalog - your gateway to a seamless experience!</p>
  <p style="color: #d3d3d3; margin-bottom: 20px;">We are thrilled to have you onboard! Join us and unlock a world of opportunities.</p>
  
  <h1 style="color: green; font-weight: bold;">Congratulations</h1>
  <p>Your shop, <strong>$ventureName</strong>, has successfully completed the registration process. We appreciate your efforts in adhering to our guidelines and completing the registration process properly.</p>
  <p>Your registration ID is:</p>
  <p style="color: orange; font-weight: bold; background-color: lightgray; padding: 10px; border-radius: 5px; border: 1px solid gray; display: inline-block;">$uid</p>
  <p>Please make sure to keep your registration ID secure for future reference.</p>

  <p>If you have any further questions or need assistance, feel free to reach out to our support team anytime.</p>

  <p>Thanks</p>
  <p>Team Cavalog</p>

  <h2>Have Questions?</h2>
  <p>Need help? Contact us at <strong>$_username</strong>, and we'll be happy to assist you!</p>
  <p><small>${DateTime.now()}</small></p>
""";
    try {
      await send(message, smtpServer);
      return true;
    } on MailerException {
      return false;
    }
  }
}
