import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber_deep_link/features/uber/presentation/cubit/uber_cubit.dart';

class GoToLocationButton extends StatelessWidget {
  const GoToLocationButton({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });
  final String image;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<UberCubit, UberState>(
        buildWhen: (previous, current) => _getBuildStates(current),
        builder: (context, state) {
          if (state is GettingPlaceData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
          return ListTile(
            horizontalTitleGap: 0,
            tileColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: Image.asset(
              image,
              width: 40,
              height: 40,
            ),
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: onTap,
          );
        },
      ),
    );
  }

  bool _getBuildStates(UberState current) {
    return current is GettingPlaceData ||
        current is UberError ||
        current is RequestedDriver;
  }
}
