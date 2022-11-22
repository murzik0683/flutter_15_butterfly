import 'package:flutter/material.dart';
import 'package:flutter_5_butterfly/model.dart';

class ButerflyMobile extends StatefulWidget {
  final String name;
  final String desc;
  final String image;

  const ButerflyMobile({
    Key? key,
    required this.name,
    required this.desc,
    required this.image,
  }) : super(key: key);

  @override
  State<ButerflyMobile> createState() => _ButerflyMobileState();
}

class _ButerflyMobileState extends State<ButerflyMobile>
    with TickerProviderStateMixin {
  late AnimationController dropController;
  late Animation<double> cardController;
  late Animation<double> iconController;

  bool show = true;

  @override
  void initState() {
    dropController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    cardController = Tween(begin: 0.0, end: 1.0).animate(dropController);
    iconController = Tween(begin: 0.0, end: -0.5).animate(dropController);
    super.initState();
  }

  @override
  void dispose() {
    dropController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                color: show ? Colors.white : Colors.blue,
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
                    color: show ? Colors.black : Colors.blue, fontSize: 20),
              ),
              trailing: RotationTransition(
                turns: iconController,
                child: IconButton(
                    icon: Icon(
                      Icons.expand_more,
                      color: show ? Colors.black : Colors.blue,
                    ),
                    onPressed: () {
                      show
                          ? dropController.forward()
                          : dropController.reverse();
                      setState(() {
                        show = !show;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бабочки'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //_buildSearchForm(),
            _buildTextMain(),
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(20),
                itemCount: butterfly.length,
                itemBuilder: (BuildContext context, int index) {
                  Butterfly butter = butterfly[index];
                  return ButerflyMobile(
                    name: butter.name,
                    desc: butter.desc,
                    image: butter.image,
                  );
                }),
          ],
        ),
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
        width: 250,
        child: const Center(
          child: Text(
            'Бабочка',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  int _selectedIndex = -1;

  final _controller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
          onChanged: (value) {
            setState(() {});
            if (_formKey.currentState!.validate()) {
              for (int i = 0; i < butterfly.length; i++) {
                String nameButterfly = butterfly.elementAt(i).name;
                if (nameButterfly.contains(_controller.value.text)) {
                  flag = false;
                  _selectedIndex = i;
                  //FocusScope.of(context).requestFocus(FocusNode());
                  //FocusManager.instance.primaryFocus?.unfocus();
                  //FocusScope.of(context).unfocus();
                }
              }
              if (flag) {
                _selectedIndex = -1;

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      'Такой бабочки "${_controller.value.text}" нет в списке'),
                  backgroundColor: Colors.red,
                ));
              }
            }
          },
        ),
      ),
    );
  }
}
