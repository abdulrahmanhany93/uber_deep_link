import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_deep_link/features/uber/presentation/cubit/uber_cubit.dart';
import 'package:uber_deep_link/features/uber/presentation/widgets/go_to_location_button.dart';
import 'package:uber_deep_link/features/uber/presentation/widgets/location_link_field.dart';
import 'package:uber_deep_link/gen/assets.gen.dart';
import 'package:uber_deep_link/util/service/service_locator.dart';

class DeepLinkPage extends StatefulWidget {
  const DeepLinkPage({super.key});

  @override
  State<DeepLinkPage> createState() => _DeepLinkPageState();
}

late TextEditingController _controller;

class _DeepLinkPageState extends State<DeepLinkPage> {
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<UberCubit>(
        create: (context) => sl<UberCubit>(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocListener<UberCubit, UberState>(
                listener: (context, state) {
                  if (state is UberError) {
                    log('Error: ${state.message}');
                  }
                  if (state is GotPlaceData) {
                    context.read<UberCubit>().requestDriver(state.place);
                    _controller.clear();
                  }
                },
                child: const SizedBox.shrink(),
              ),
              Image.asset(Assets.background.path),
              LocationLinkField(controller: _controller),
              GoToLocationButton(
                title: 'Go With Uber',
                image: Assets.uber.path,
                onTap: () => sl<UberCubit>().getPlace(_controller.text),
              )
            ],
          ),
        ),
      ),
    );
  }
}
