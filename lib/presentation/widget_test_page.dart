import 'package:flutter/material.dart';
import 'package:gluon/presentation/components/custom_text_field.dart';

class WidgetTestPage extends StatefulWidget {
  final String title;

  const WidgetTestPage({super.key, required this.title});

  @override
  State<WidgetTestPage> createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  TextEditingController controller = TextEditingController();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: key,
            child: CustomTextField(
              controller: controller,
              title: 'Username',
              tooltipKey: tooltipKey,
              tooltipMessage: 'username cannot be empty',
              prefixIcon: const Icon(Icons.person, color: Colors.grey),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return true;
                } else {
                  return false;
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => key.currentState?.validate(),
        child: const Text('submit'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
