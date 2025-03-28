import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class RejectionEmailService {
  final String _username = 'cavlogenoia@gmail.com';
  final String _password = 'ayjl rukr sjam ucxs';

  Future<bool> sendRejectEmail(String recipientEmail, String barberName,String ventureName, String uid, String reason) async {
    final smtpServer = gmail(_username, _password);

    final message = Message()
      ..from = Address(_username, "Cavalog Official")
      ..recipients.add(recipientEmail)
      ..subject =
          "Application Verification Update: $barberName - ${DateTime.now()}"
      ..text = """
         Hello $barberName,
         Thank you for your application to Cavalog. Unfortunately, your verification process could not be completed at this time due to the following reason: $reason. 
        """
        ..html = """
      <h1 style="color: orange;">Team Cavalog</h1>
      <p><strong style="font-weight: bold;">Dear $barberName,</strong></p>
      <p>Thank you for your application to join Cavalog. We appreciate the effort you have invested in the process.</p>
      <h2 style="color: red; font-weight: bold;">Verification Update</h2>
      <p>After careful review, we regret to inform you that the verification process for your shop, <strong>$ventureName</strong>, could not be successfully completed. The reason for this decision is as follows: $reason</p>
      <p>Your unique Registration ID is:</p>
      <p style="color: orange; font-weight: bold; background-color: lightgray; padding: 10px; border-radius: 5px; border: 1px solid gray; display: inline-block;">$uid</p>
      <p>Please ensure this ID is kept safe for any future reference.</p>

      <p>We truly value your interest in becoming a part of Cavalog. While we cannot proceed with your application at this time, we encourage you to reapply after addressing the above issue. Our team is here to guide you and make the process smoother.</p>

      <p>If you have any questions or need further clarification, please do not hesitate to reach out to us at <strong>$_username</strong>. We’re always here to help!</p>

      <p>Thank you for considering Cavalog, and we hope to work with you in the future.</p>

      <p>Sincerely,</p>
      <p><strong>Team Cavalog</strong></p>
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
