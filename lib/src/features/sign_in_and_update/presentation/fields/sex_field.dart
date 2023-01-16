import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/cliente/model/cliente_model_provider.dart';
import '../../../common_widgets/headers_screens/header_screens.dart';
import '../../../../providers/forms/sex/sex_provider.dart';

class SexFormField extends ConsumerWidget {
  const SexFormField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width * .90,
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              H3FormFieldsHeader(header:'Select your sex:'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  RadarMale(),
                  RadarFemale(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RadarMale extends ConsumerWidget {
  const RadarMale({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            title: const Text('Male'),
            leading: Radio(
              value: Sex.male,
              groupValue: ref.watch(sexProvider),
              onChanged: (Sex? value) {
                ref.watch(sexProvider.notifier).state = value!;
                ref.watch(clientProvider).setSex(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RadarFemale extends ConsumerWidget {
  const RadarFemale({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Column(
        children: [
          ListTile(
            title: const Text('Female'),
            leading: Radio<Sex>(
              value: Sex.female,
              groupValue: ref.watch(sexProvider),
              onChanged: (Sex? value) {
                ref.watch(sexProvider.notifier).state = value!;
                ref.watch(clientProvider).setSex(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
