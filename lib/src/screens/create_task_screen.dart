import 'dart:io';
import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/src/models/task.dart';
import 'package:todoapp/src/repository/task_repository.dart';

class CreateTaskScreen extends StatefulWidget {
  final Task? task;
  CreateTaskScreen({this.task});
  State<StatefulWidget> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  var _image;
  var imagePicker;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _id = '';
  String _title = '';
  String _subTitle = '';
  String _content = '';
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subTitleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  DateTime _deadline = DateTime.now();
  String _urlToImage = '';
  String _url = '';
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    if (widget.task != null) {
      _id = widget.task!.id!;
      _titleController.text = widget.task!.title;
      _subTitleController.text = widget.task!.subTitle;
      _contentController.text = widget.task!.content;
      _title = widget.task!.title;
      _subTitle = widget.task!.subTitle;
      _content = widget.task!.content;
      _deadline = widget.task!.deadline;
      _url = widget.task!.urlToImage!;
      TaskRepository().downloadURL(_url).then((value) {
        _urlToImage = value;
        setState(() {
          _urlToImage = value;
        });
      });
      print("URL = " + _urlToImage);
    }
  }

  _getImage(ImageSource source) async {
    XFile? image = await imagePicker!.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
    Get.back();
  }

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Choose A Photo From Library'),
                      onTap: () {
                        _getImage(ImageSource.gallery);
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Choose A Photo From Camera'),
                    onTap: () {
                      _getImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey.shade700,
            size: 20,
          ),
        ),
        title: Text(
          widget.task == null ? "Create Task" : "Edit Task",
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (widget.task == null) {
                    if (_image == null)
                      _image = '';
                    else
                      _image = _image.path;
                    bool isSuccess = await TaskRepository().createTask(
                      title: _title,
                      subTitle: _subTitle,
                      content: _content,
                      deadline: _deadline,
                      image: _image,
                    );
                    Get.back();
                    if (isSuccess) {
                      Get.back();
                    } else {}
                  } else {
                    if (_image == null)
                      _image = '';
                    else
                      _image = _image.path;
                    bool isSuccess = await TaskRepository().editTask(
                      id: _id,
                      title: _title,
                      subTitle: _subTitle,
                      content: _content,
                      deadline: _deadline,
                      image: _image.toString(),
                    );

                    Get.back();
                  }
                }
              },
              icon: Icon(
                Icons.check,
                color: Colors.blueAccent,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildInputField(
                label: 'Title',
                controller: _titleController,
                validatorString: 'Please type title',
              ),
              _buildInputField(
                label: 'Subtitle',
                controller: _subTitleController,
                validatorString: 'Please type sub title',
              ),
              SizedBox(
                height: 18,
              ),
              Text(
                "Add A Photo",
                style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade800),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: GestureDetector(
                    onTap: () async {
                      _showPicker(context);
                    },
                    child: _image != null
                        ? Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover)),
                          )
                        : Container(
                            width: 250,
                            height: 250,
                            child: _urlToImage == ''
                                ? Icon(Icons.add_a_photo)
                                : Image(image: NetworkImage(_urlToImage), fit: BoxFit.cover,),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                          )),
              ),
              SizedBox(height: 10),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                initialValue: DateTime.now().toString(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                dateLabelText: 'Deadline',
                timeLabelText: 'Hour',
                icon: Icon(Icons.add_alert_sharp),
                onChanged: (val) {
                  DateTime picker = DateTime.parse(val);
                  if (picker.compareTo(DateTime.now()) > 0) {
                    print(picker.toString());
                  }
                  print("URL: $_url");
                  print(_urlToImage);
                },
              ),
              _buildInputField(
                label: 'Content',
                controller: _contentController,
                validatorString: 'Please type content',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
      {String? label,
      TextEditingController? controller,
      String? validatorString}) {
    return TextFormField(
      validator: (String? a) {
        if (a!.trim().length == 0) {
          return validatorString;
        }
        return null;
      },
      onChanged: (val) {
        switch (label) {
          case 'Title':
            setState(() {
              _title = val.trim();
            });
            break;
          case 'Subtitle':
            setState(() {
              _subTitle = val.trim();
            });
            break;
          case 'Content':
            setState(() {
              _content = val.trim();
            });
            break;
        }
      },
      style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          color: Colors.grey.shade800),
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade800),
      ),
      maxLines: null,
    );
  }
}
