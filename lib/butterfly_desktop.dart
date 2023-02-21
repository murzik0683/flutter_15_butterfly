import 'package:flutter/material.dart';
import 'package:flutter_5_butterfly/model.dart';

class ButerflyDesktop extends StatefulWidget {
  const ButerflyDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<ButerflyDesktop> createState() => _ButerflyDesktopState();
}

class _ButerflyDesktopState extends State<ButerflyDesktop> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                _buildTextMain(),
                SizedBox(
                  width: 550,
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
                    _buildImage(),
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

  Widget _buildImage() {
    return _selectedIndex == -1
        ? const Text(
            '',
            style: TextStyle(fontSize: 24, color: Colors.blue),
          )
        : Center(
            child: CircleAvatar(
              backgroundImage:
                  AssetImage(butterfly.elementAt(_selectedIndex).image),
              radius: 100,
            ),
          );
  }

  Widget _buildTextMain() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        height: 60,
        width: 350,
        child: const Center(
          child: Text(
            'Бабочка',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
