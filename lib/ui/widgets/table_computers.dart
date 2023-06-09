import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unica_cybercoffee/domain/models/computer.dart';
import 'package:unica_cybercoffee/domain/models/computer_ui.dart';
import 'package:unica_cybercoffee/ui/providers/editable_ui_provider.dart';
import 'package:unica_cybercoffee/ui/widgets/computer_widget.dart';

class TableComputers extends StatefulWidget {
  const TableComputers(
      {super.key, required this.computers, required this.editableUIProvider});
  final List<Computer> computers;
  final EditableUIProvider editableUIProvider;

  @override
  State<TableComputers> createState() => _TableComputersState();
}

class _TableComputersState extends State<TableComputers> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulación de una operación que tarda 2 segundos en completarse
    Future.delayed(
        Duration(milliseconds: widget.editableUIProvider.editable ? 50 : 50),
        () {
      setState(() {
        isLoading = false;
      });
    });
  }

  List<Widget> getComputers() {
    List<Widget> computerView = [];

    for (var computer in widget.computers) {
      computerView.add(ComputerWidget(computer: computer));
    }
    return computerView;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : Stack(
            children: getComputers(),
          );
  }
}
