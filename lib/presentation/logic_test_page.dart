import 'package:flutter/material.dart';
import 'package:gluon/presentation/components/custom_text_field.dart';
import 'package:gluon/utils/convert.dart';

class LogicTestPage extends StatefulWidget {
  final String title;

  const LogicTestPage({super.key, required this.title});

  @override
  State<LogicTestPage> createState() => _LogicTestPageState();
}

class _LogicTestPageState extends State<LogicTestPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController resController = TextEditingController();
  final key = GlobalKey<FormState>();
  final tooltipKey = GlobalKey<TooltipState>();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      key.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: key,
              child: CustomTextField(
                controller: controller,
                title: 'Input',
                tooltipKey: tooltipKey,
                keyboardType: const TextInputType.numberWithOptions(),
                suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return false;
                  } else {
                    return true;
                  }
                },
                tooltipMessage: '',
              ),
            ),
            CustomTextField(
              controller: resController,
              title: 'Output',
              tooltipKey: tooltipKey,
              validator: (_) => true,
              tooltipMessage: '',
              isReadOnly: true,
            ),

            ElevatedButton(onPressed: (){
               try {
                 final input = int.parse(controller.text);
                 if (input > 999999999999999) throw Exception('limit reached more than 999999999999999');
                 resController.text = NumberToWords.convert(input);
               } catch (e) {
                 resController.clear();
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
               }
            }, child: const Text('Convert')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
