import 'package:flutter/material.dart';
import 'package:flutter_5_butterfly/model.dart';

class ButerflyPlanshet extends StatefulWidget {
  const ButerflyPlanshet({
    Key? key,
  }) : super(key: key);

  @override
  State<ButerflyPlanshet> createState() => _ButerflyPlanshetState();
}

class _ButerflyPlanshetState extends State<ButerflyPlanshet> {
  int _selectedIndex = -1;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final currentWidthPlanshet = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Бабочки'), centerTitle: true),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        width: 250, height: 100, child: _buildSearchForm()),
                    SizedBox(
                      width: 120, height: 90,
                      //child: _button()
                    ),
                  ],
                ),
                SizedBox(
                  width: currentWidthPlanshet > 1024 ? 550 : 350,
                  child: ListView.builder(
                      //controller: ScrollController(),
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.all(10),
                      itemCount: butterfly.length,
                      itemBuilder: (BuildContext context, int index) {
                        Butterfly butter = butterfly[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              width: 2,
                              color: _selectedIndex == index
                                  ? Colors.blue
                                  : Colors.white,
                            ),
                          ),
                          child: ListTile(
                            leading: ClipOval(
                              child: Image(
                                image: AssetImage(butter.image),
                                width: 50,
                                height: 35,
                              ),
                            ),
                            title: Text(butter.name,
                                style: const TextStyle(fontSize: 20)),
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                              });
                            },
                            selected: index == _selectedIndex,
                          ),
                        );
                      }),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImage(currentWidthPlanshet),
                    _buildText(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText() {
    return Text(
      _selectedIndex == -1 ? ('') : butterfly.elementAt(_selectedIndex).desc,
      style: const TextStyle(
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildImage(currentWidthPlanshet) {
    return _selectedIndex == -1
        ? const Text(
            '',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          )
        : Center(
            child: CircleAvatar(
                backgroundImage:
                    AssetImage(butterfly.elementAt(_selectedIndex).image),
                radius: currentWidthPlanshet > 1024 ? 100 : 80),
          );
  }

  // Widget _buildTextMain() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         border: Border.all(
  //           color: Colors.blue,
  //           width: 2,
  //         ),
  //       ),
  //       height: 60,
  //       width: 250,
  //       child: const Center(
  //         child: Text(
  //           'Бабочка',
  //           style: TextStyle(fontSize: 20),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSearchForm() {
    bool flag = true;
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'Поиск',
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Название бабочки',
            suffixIcon: IconButton(
              onPressed: _controller.clear,
              icon: const Icon(Icons.clear),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Введите имя бабочки';
            return null;
          },
          onFieldSubmitted: (value) {
            //отдает строку кот. можно исп-ть

            if (value.isNotEmpty) {
              final searchedIndex =
                  butterfly.indexWhere((e) => e.name.contains(value));

              if (searchedIndex >= 0) {
                setState(() {});
                // showA = true;
                // print('showA $showA');

                _selectedIndex = searchedIndex;
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Такой бабочки "${_controller.value.text}" нет в списке 😞'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          // onChanged: (value) {
          //   setState(() {});
          //   if (_formKey.currentState!.validate()) {
          //     for (int i = 0; i < butterfly.length; i++) {
          //       String nameButterfly = butterfly.elementAt(i).name;
          //       if (nameButterfly.contains(_controller.value.text)) {
          //         flag = false;
          //         _selectedIndex = i;
          //         //FocusScope.of(context).requestFocus(FocusNode());
          //         //FocusManager.instance.primaryFocus?.unfocus();
          //         //FocusScope.of(context).unfocus();
          //       }
          //     }
          //     if (flag) {
          //       _selectedIndex = -1;

          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          //         content: Text(
          //             'Такой бабочки "${_controller.value.text}" нет в списке'),
          //         backgroundColor: Colors.red,
          //       ));
          //     }
          //   }
          // },
        ),
      ),
    );
  }

  // Widget _button() {
  //   bool flag = true;
  //   return Container(
  //     margin: const EdgeInsets.all(20),
  //     width: MediaQuery.of(context).size.width * 0.4,
  //     height: MediaQuery.of(context).size.height * 0.05,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(15),
  //       gradient: const LinearGradient(
  //         colors: [Color.fromARGB(255, 153, 207, 252), Colors.blue],
  //         begin: FractionalOffset.centerLeft,
  //         end: FractionalOffset.centerRight,
  //       ),
  //     ),
  //     child: TextButton(
  //       onPressed: () {
  //         setState(() {});
  //         if (_formKey.currentState!.validate()) {
  //           for (int i = 0; i < butterfly.length; i++) {
  //             String nameButterfly = butterfly.elementAt(i).name;
  //             if (nameButterfly.startsWith(_controller.value.text)) {
  //               flag = false;
  //               _selectedIndex = i;
  //               FocusScope.of(context).unfocus();
  //             }
  //           }
  //           if (flag) {
  //             _selectedIndex = -1;

  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text(
  //                   'Такой бабочки "${_controller.value.text}" нет в списке'),
  //               backgroundColor: Colors.red,
  //             ));
  //           }
  //         }
  //       },
  //       child: const Text(
  //         'Найти',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }
}
