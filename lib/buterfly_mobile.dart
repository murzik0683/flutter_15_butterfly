// import 'package:flutter/material.dart';
// import 'package:my_notes/screens/lesson_15/model.dart';

// class ButerflyMobile extends StatefulWidget {
//   final String name;
//   final String desc;
//   final String image;
//   bool showAnim;
//   int id;
//   ButerflyMobile({
//     Key? key,
//     required this.name,
//     required this.desc,
//     required this.image,
//     required this.showAnim,
//     required this.id,
//   }) : super(key: key);

//   @override
//   State<ButerflyMobile> createState() => _ButerflyMobileState();
// }

// class _ButerflyMobileState extends State<ButerflyMobile>
//     with TickerProviderStateMixin {
//   late AnimationController dropController;
//   late Animation<double> cardController;
//   late Animation<double> iconController;

//   bool show = true;

//   @override
//   void initState() {
//     dropController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     cardController = Tween(begin: 0.0, end: 1.0).animate(dropController);
//     iconController = Tween(begin: 0.0, end: -0.5).animate(dropController);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     dropController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: 350,
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//               side: BorderSide(
//                 width: 2,
//                 color: show ? Colors.white : Colors.blue,
//               ),
//             ),
//             child: ListTile(
//               leading: ClipOval(
//                 child: Image(
//                   image: AssetImage(widget.image),
//                   width: 50,
//                   height: 35,
//                 ),
//               ),
//               title: Text(
//                 widget.name,
//                 style: TextStyle(
//                     color: show ? Colors.black : Colors.blue, fontSize: 20),
//               ),
//               trailing: RotationTransition(
//                 turns: iconController,
//                 child: IconButton(
//                     icon: Icon(
//                       Icons.expand_more,
//                       color: show ? Colors.black : Colors.blue,
//                     ),
//                     onPressed: () {
//                       show
//                           ? dropController.forward()
//                           : dropController.reverse();
//                       setState(() {
//                         show = !show;
//                       });
//                     }),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 350,
//           child: SizeTransition(
//             sizeFactor: cardController,
//             axis: Axis.vertical,
//             axisAlignment: 1.0,
//             child: Card(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20),
//                     bottomRight: Radius.circular(20)),
//                 side: BorderSide(
//                   width: 2,
//                   color: Colors.blue,
//                 ),
//               ),
//               child: ListTile(
//                 title: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: CircleAvatar(
//                         backgroundImage: AssetImage(widget.image),
//                         radius: 60,
//                       ),
//                     ),
//                     Text(
//                       widget.desc,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ButerflyMobileList extends StatefulWidget {
//   ButerflyMobileList({super.key});

//   @override
//   State<ButerflyMobileList> createState() => _ButterflyMobileListState();
// }

// class _ButterflyMobileListState extends State<ButerflyMobileList> {
//   bool showA = false;
//   String? searchQuery;

//   @override
//   Widget build(BuildContext context) {
//     final filteredButterfly = searchQuery == null
//         ? butterfly
//         : butterfly
//             .where((butter) =>
//                 butter.name.toLowerCase().contains(searchQuery!.toLowerCase()))
//             .toList();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Бабочки'), centerTitle: true),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             _buildSearchForm(),
//             if (searchQuery != null && filteredButterfly.isEmpty)
//               const Text('Ничего не найдено'),
//             for (final butterfly in filteredButterfly)
//               ListTile(
//                 title: Text(butterfly.name),
//                 leading: CircleAvatar(
//                   backgroundImage: AssetImage(butterfly.image),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchForm() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         decoration: InputDecoration(
//           hintText: 'Поиск...',
//           suffixIcon: searchQuery == null || searchQuery!.isEmpty
//               ? null
//               : IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () {
//                     setState(() {
//                       searchQuery = null;
//                     });
//                   },
//                 ),
//         ),
//         onChanged: (value) {
//           setState(() {
//             searchQuery = value.isNotEmpty ? value : null;
//           });
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_5_butterfly/model.dart';

int _selectedIndex = -1;

class ButerflyMobile extends StatefulWidget {
  final String name;
  final String desc;
  final String image;
  bool showAnim;
  int id;
  ButerflyMobile({
    Key? key,
    required this.name,
    required this.desc,
    required this.image,
    required this.showAnim,
    required this.id,
  }) : super(key: key);

  @override
  State<ButerflyMobile> createState() => _ButerflyMobileState();
}

class _ButerflyMobileState extends State<ButerflyMobile>
    with TickerProviderStateMixin {
  late AnimationController dropController;
  late Animation<double> cardController;
  late Animation<double> iconController;

  @override
  void initState() {
    dropController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    cardController = Tween(begin: 0.0, end: 1.0).animate(dropController);
    iconController = Tween(begin: 0.0, end: -0.5).animate(dropController);

    widget.showAnim = false;

    super.initState();
  }

  @override
  void dispose() {
    dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showAnim) {
      dropController.forward();
    } else {
      dropController.reverse();
    }

    return Column(
      children: [
        SizedBox(
          width: 350,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              side: BorderSide(
                width: 2,
                color: widget.showAnim ? Colors.blue : Colors.white,
              ),
            ),
            child: ListTile(
              leading: ClipOval(
                child: Image(
                  image: AssetImage(widget.image),
                  width: 50,
                  height: 35,
                ),
              ),
              title: Text(
                widget.name,
                style: TextStyle(
                    color: widget.showAnim ? Colors.blue : Colors.black,
                    fontSize: 20),
              ),
              trailing: RotationTransition(
                turns: iconController,
                child: IconButton(
                    icon: Icon(
                      Icons.expand_more,
                      color: widget.showAnim ? Colors.blue : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.showAnim = !widget.showAnim;
                      });
                    }),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 350,
          child: SizeTransition(
            sizeFactor: cardController,
            axis: Axis.vertical,
            axisAlignment: 1.0,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                side: BorderSide(
                  width: 2,
                  color: Colors.blue,
                ),
              ),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        backgroundImage: AssetImage(widget.image),
                        radius: 60,
                      ),
                    ),
                    Text(
                      widget.desc,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ButerflyMobileList extends StatefulWidget {
  const ButerflyMobileList({super.key});

  @override
  State<ButerflyMobileList> createState() => _ButerflyMobileListState();
}

class _ButerflyMobileListState extends State<ButerflyMobileList> {
  bool showA = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Бабочки'),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchForm(),
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(20),
                itemCount: butterfly.length,
                itemBuilder: (BuildContext context, int index) {
                  Butterfly butter = butterfly[index];

                  print('butter.showAnim ${butter.showAnim}');
                  return ButerflyMobile(
                    name: butter.name,
                    desc: butter.desc,
                    image: butter.image,
                    showAnim: butter.id == _selectedIndex,
                    id: butter.id,
                  );
                }),
          ],
        ),
      ),
    );
  }

  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Widget _buildSearchForm() {
    return Container(
      height: 100,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          controller: _controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 3, color: Colors.blue),
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Название бабочки',
            prefixIcon: IconButton(
              onPressed: _controller.clear,
              icon: const Icon(Icons.clear),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = butterfly.indexWhere((butterfly) => butterfly
                      .name
                      .toLowerCase()
                      .contains(_controller.value.text.toLowerCase()));

                  if (_selectedIndex == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Такой бабочки "${_controller.value.text}" нет в списке 😞'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  showA = true;
                  FocusScope.of(context).requestFocus(FocusNode());
                });
              },
              icon: const Icon(Icons.search),
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) return 'Введите имя бабочки';
            return null;
          },
          onFieldSubmitted: _onSearch,
        ),
      ),
    );
  }

  void _onSearch(String query) {
    setState(() {
      _selectedIndex = butterfly.indexWhere((butterfly) =>
          butterfly.name.toLowerCase().contains(query.toLowerCase()));

      if (_selectedIndex == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Такой бабочки "${_controller.value.text}" нет в списке 😞'),
            backgroundColor: Colors.red,
          ),
        );
      }
      showA = true;
      FocusScope.of(context).requestFocus(FocusNode());
    });
  }
}
