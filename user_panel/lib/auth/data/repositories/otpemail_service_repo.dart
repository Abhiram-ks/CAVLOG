import 'dart:developer';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class EmailService {
  final String _username = 'cavlogenoia@gmail.com';
  final String _password = 'ayjl rukr sjam ucxs';

  Future<bool> sendOTPEmail(String recipientEmail, String otp) async {
    final smtpServer = gmail(_username, _password);

    final message = Message()
      ..from = Address(_username, "Cavalog Official")
      ..recipients.add(recipientEmail)
      ..subject = "Your OTP for Verification - ${DateTime.now()}"
      ..text = """
             Hello user!
             Welcome to Cavalog - your gateway to a seamless experience!
             Here's your OTP: $otp
            """
      ..html = """
      <h1><strong style="color: orange;">Team Cavalog</strong></h1>
      <p>Hello,</p>
      <p>Welcome to Cavlog - your gateway to a seamless experience!</p>
      <p style="color: #d3d3d3; margin-bottom: 30px;">Join us and unlock a world of possibilities.</p>
      <p>Here's your OTP: <span style="color: orange; font-weight: bold; background-color: lightgray; padding: 5px 10px; border-radius: 5px; display: inline-block;">$otp</span></p>
      <p><small style="color: red;">OTP will expire at ${DateTime.now().add(Duration(minutes: 2))}</small></p>








 
      <h2>HAVE QUESTIONS?</h2>
      <p>Need help? Contact us at <strong>$_username</strong>, and we'll assist you!</p>
      <p><small>${DateTime.now()}</small></p>
    """;
    try {
      await send(message, smtpServer);
      log('OTP sent successfully to: $recipientEmail');
      return true;
    } on MailerException catch (e) {
      log('faild to send OTP : ${e.toString()}');
      return false;
    }
  }
}
