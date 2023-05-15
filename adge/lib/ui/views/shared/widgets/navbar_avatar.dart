import 'package:adge/providers/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user!;

    final image = (user.img == null || user.img == '')
        ? const Image(image: AssetImage('no-image.jpg'))
        : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);

    return ClipOval(
      child: Container(
        child: image,
        width: 30,
        height: 30,
      ),
    );
  }
}
