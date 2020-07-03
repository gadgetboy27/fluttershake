import 'package:flutter/material.dart';
import 'package:fluttershake/src/styles/base.dart';
import 'package:fluttershake/src/styles/buttons.dart';
import 'package:fluttershake/src/styles/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSocialButton extends StatelessWidget {
  final SocialType socialType;

  AppSocialButton({@required this.socialType});
  @override
  Widget build(BuildContext context) {
    Color iconColor;
    Color buttonColor;
    IconData icon;

    switch (socialType) {
      case SocialType.Facebook:
      iconColor = Colors.white;
      buttonColor = AppColors.facebook;
      icon = FontAwesomeIcons.facebookF;
      break;
      case SocialType.Google:
      iconColor = Colors.white;
      buttonColor = AppColors.google;
      icon = FontAwesomeIcons.google;
      break;
      case SocialType.Twitter:
      iconColor = Colors.white;
      buttonColor = AppColors.twitter;
      icon = FontAwesomeIcons.twitter;
      break;
      case SocialType.Apple:
      iconColor = Colors.white;
      buttonColor = AppColors.apple;
      icon = FontAwesomeIcons.apple;
      break;
      case SocialType.Linkedin:
      iconColor = Colors.white;
      buttonColor = AppColors.linkedin;
      icon = FontAwesomeIcons.linkedinIn;
      break;
      default:
      iconColor = Colors.white;
      buttonColor = AppColors.facebook;
      icon = FontAwesomeIcons.facebookF;
      break;
    }

    return Container(
      height: ButtonStyles.buttonHeight,
      width: ButtonStyles.buttonHeight,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(
          BaseStyles.borderRadius),
          boxShadow: BaseStyles.boxShadow,
      ),
      child: Icon(icon, color:iconColor),
    );
  }
}

enum SocialType { Facebook, Google, Apple, Twitter, Linkedin }