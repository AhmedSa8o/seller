import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/on_boarding/controller/setting_cubit.dart';
import '/core/remote_urls.dart';
import '/utils/constants.dart';
import '/widgets/custom_image.dart';

class MaintainScreen extends StatelessWidget {
  const MaintainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          if (state is SettingStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SettingStateError) {
            return Center(child: Text(state.message));
          } else if (state is SettingStateLoaded) {
            final result = state.settingModel.maintainTextModel;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomImage(
                        path: RemoteUrls.imageUrl(
                            state.settingModel.maintainTextModel!.image)),
                    const SizedBox(height: 20.0),
                    Text(
                      result!.description,
                      style:
                          GoogleFonts.jost(fontSize: 18.0, color: blackColor),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
