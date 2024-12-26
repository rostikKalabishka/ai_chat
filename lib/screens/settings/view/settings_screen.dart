import 'package:ai_chat/blocs/theme_cubit/theme_cubit.dart';
import 'package:ai_chat/blocs/user_bloc/user_bloc.dart';
import 'package:ai_chat/core/routes/router.dart';
import 'package:ai_chat/core/ui/ui.dart';
import 'package:ai_chat/core/ui/widgets/confirmation_dialog.dart';
import 'package:ai_chat/generated/l10n.dart';
import 'package:ai_chat/screens/settings/bloc/settings_bloc.dart';
import 'package:ai_chat/screens/settings/widgets/settings_action_card.dart';
import 'package:ai_chat/screens/settings/widgets/settings_toggle_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:user_repository/user_repository.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? _appInfoString;

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    _appInfoString =
        '${packageInfo.appName} v${packageInfo.version} (${packageInfo.buildNumber})';

    setState(() {});
  }

  @override
  void initState() {
    _loadAppVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = context.watch<ThemeCubit>().state.isDark;
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (BuildContext context, state) {
        if (state is SettingsSignOutSuccessState) {
          AutoRouter.of(context)
              .pushAndPopUntil(const SignInRoute(), predicate: (_) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: TextWidget(
            label: S.of(context).settings,
            fontSize: 24,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                final userModel = state.userModel;
                return Column(
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () => _uploadPicture(context, userModel),
                      child: MyCircleAvatar(
                        userImage: userModel.userImage,
                        radius: 50,
                      ),
                    ),
                    SettingsActionCard(
                        title: userModel.username, iconData: Icons.people_alt),
                    SettingsActionCard(
                        title: userModel.email, iconData: Icons.email),
                    SettingsToggleCard(
                      title: S.of(context).darkMode,
                      value: isDarkTheme,
                      onChanged: (value) => _setThemeBrightness(context, value),
                    ),
                    SettingsActionCard(
                        title: _appInfoString ?? '', iconData: Icons.info),
                    SettingsActionCard(
                      title: S.of(context).signOut,
                      iconData: Icons.login,
                      iconColor: Colors.redAccent,
                      onTap: () {
                        _confirmSignOut(context);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _uploadPicture(BuildContext context, UserModel userModel) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 500,
        maxWidth: 500,
        imageQuality: 40);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: [CropAspectRatioPreset.square],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Theme.of(context).colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ],
      );

      if (croppedFile != null) {
        context.read<UserBloc>().add(
            UpdateUserInfo(userImage: croppedFile.path, userModel: userModel));
      }
    }
  }

  void _confirmSignOut(BuildContext context) {
    final theme = Theme.of(context);
    final dialog = ConfirmationDialog(
      description: S.of(context).areYouSureAboutThis,
      title: S.of(context).areYouSureYouWantToLogOutOfYour,
      onConfirm: () {
        context.read<SettingsBloc>().add(SettingsSignOutEvent());
      },
    );
    if (theme.isAndroid) {
      showDialog(context: context, builder: (context) => dialog);
      return;
    }
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => dialog,
    );
  }

  void _setThemeBrightness(BuildContext context, bool value) {
    final brightness = value ? Brightness.dark : Brightness.light;
    context.read<ThemeCubit>().setThemeBrightness(brightness);
  }
}
