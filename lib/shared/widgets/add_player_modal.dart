import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/core/app_text_styles.dart';
import 'package:planning_poker_flutter/shared/repositories/local_storedge_repository.dart';

import '../core/globals.dart';
import '../core/web_socket_config.dart';
import '../models/player_model.dart';

class AddPlayerModal extends StatefulWidget {
  const AddPlayerModal({Key? key}) : super(key: key);

  @override
  State<AddPlayerModal> createState() => _AddPlayerModalState();
}

class _AddPlayerModalState extends State<AddPlayerModal> {
  bool _isSpectador = false;
  bool _isNotValid = false;
  final _textController = TextEditingController();
  final localStoredge = LocalStoredgeRepository();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var logged = await localStoredge.getPlayerLogged();
      if (logged != null) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: SingleChildScrollView(
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose your display name',
                  style: AppTextStyles.title,
                ),
                SizedBox(height: 50),
                TextField(
                  controller: _textController,
                  onTap: () {
                    setState(() {
                      _isNotValid = false;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Your display name',
                    border: OutlineInputBorder(),
                    errorText: _getErrorMessage(),
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoSwitch(
                        value: _isSpectador,
                        onChanged: (value) {
                          super.setState(() {
                            _isSpectador = value;
                          });
                        }),
                    Text('Join as spectator', style: AppTextStyles.body),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      super.setState(() {
                        _isNotValid = _textController.text.trim().isEmpty;
                        if (_isNotValid) {
                          return;
                        }
                        socketClient.send(
                            destination: REGISTER, body: _textController.text);
                        localStoredge.addPlayer(PlayerModel(
                            name: _textController.text, vote: 'PP'));
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text('Continue to game',
                        style: AppTextStyles.buttonWhite),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Login', style: AppTextStyles.button),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text('Sign Up', style: AppTextStyles.button)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _getErrorMessage() {
    if (_isNotValid & _textController.text.isEmpty) {
      return "Please enter a display name!";
    }
    return null;
  }
}
