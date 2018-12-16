import 'package:flutter/material.dart' hide runApp;
import 'package:photo/photo.dart';
import 'package:photo_manager/photo_manager.dart';
import '../components/container.dart';
import '../components/button.dart';

class PickImagePage extends StatefulWidget {
  PickImagePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<PickImagePage> with GetContainer, Button {
  String currentSelected = "";
  void _pickImage() async {
    List<AssetEntity> imgList = await PhotoPicker.pickImage(
      context: context,
      // BuildContext requied

      /// The following are optional parameters.
      themeColor: Colors.green,
      // the title color and bottom color
      padding: 1.0,
      // item padding
      dividerColor: Colors.grey,
      // divider color
      disableColor: Colors.grey.shade300,
      // the check box disable color
      itemRadio: 0.88,
      // the content item radio
      maxSelected: 8,
      // max picker image count
      provider: I18nProvider.chinese,
      // i18n provider ,default is chinese. , you can custom I18nProvider or use ENProvider()
      rowCount: 5,
      // item row count
      textColor: Colors.white,
      // text color
      thumbSize: 150,
      // preview thumb size , default is 64
      sortDelegate: SortDelegate.common,
      // default is common ,or you make custom delegate to sort your gallery
      checkBoxBuilderDelegate: DefaultCheckBoxBuilderDelegate(
        activeColor: Colors.white,
        unselectedColor: Colors.white,
      ), // default is DefaultCheckBoxBuilderDelegate ,or you make custom delegate to create checkbox

      //loadingDelegate:
      //    this, // if you want to build custom loading widget,extends LoadingDelegate [see example/lib/main.dart]
    );

    if (imgList == null) {
      currentSelected = "not select item";
    } else {
      List<String> r = [];
      for (var e in imgList) {
        var file = await e.file;
        r.add(file.absolute.path);
      }
      currentSelected = r.join("\n\n");
    }
    setState(() {});
  }

  Widget getBody() {
    return this.getContainer(
      Column(
        children: <Widget>[
          commonButton("PickImage", () {
            _pickImage();
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: getBody(),
    );
  }
}
