import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/helper/helper.dart';
import 'package:newsapp/providers/Main_provider.dart';
import 'package:newsapp/screens/internet.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../models/news_model.dart';

/*import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {*/
class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
bool edit = false;
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var news_model = News_model(
    id: null,
    title: '',
    desc: '',
    imgurl: '',
  );
  var _initValues = {
    'title': '',
    'desc': '',
    'imgurl': '',
  };
  var _isInit = true;

  @override
  void initState() {
    Provider.of<Main_provider>(context,listen: false).checkinternet();
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

Future<void> getdoc(String newsId)async{
 final b= await  FirebaseFirestore.instance.collection("favo").doc("usersposts").
       collection(FirebaseAuth.instance.currentUser!.uid).doc(newsId).get();
       print(b.data());
       news_model.id = b.id;
       news_model.title = b.data()!['title'];
           news_model.desc = b.data()!['desc'];
               news_model.imgurl = b.data()!['imgurl'];
}
  @override
  void didChangeDependencies() {
    if (_isInit) {
      final newsId = ModalRoute.of(context)!.settings.arguments as String;
      if (newsId != ''){
        edit = true;
    getdoc(newsId).then((value) {
        print("xxxxxxxxxxxxxxxxxxxxxxxx");
      
       _initValues['title'] = news_model.title;
     
        _initValues['desc'] = news_model.desc;
        
         _imageUrlController.text = news_model.imgurl;
         print(_imageUrlController.text);
        
    });
     
       

        //     news_model =
        //    Provider.of<Products>(context, listen: false).findById(productId);
      
            
       
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
   
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.endsWith('.png') &&
          !_imageUrlController.text.endsWith('.jpg') &&
          !_imageUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    if (news_model.id != null) {
     FireStoreHelper.fireStoreHelper.update(news_model.id!, news_model);
    } else {
      Provider.of<Main_provider>(context, listen: false).addnews(news_model);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
Provider.of<Main_provider>(context);
    return Scaffold(
      appBar: AppBar(
        title:edit?Text("edit").tr(): Text("add").tr(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Provider.of<Main_provider>(context).hasinternet==false?internet()  : FutureBuilder<Object>(
          future: Future.value(FirebaseAuth.instance.currentUser),
          builder: (context, snapshot) {
            return Padding(
              padding: EdgeInsets.all(16.0.sp),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                  
                     initialValue: _initValues['title'],
                  
                      decoration: InputDecoration(labelText: EasyLocalization.of(context)!.currentLocale==Locale('en','')?'Title':"العنوان"),
                      textInputAction: TextInputAction.next,
                     
                      validator: (value) {
                        if (value!.isEmpty) {
                          return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Title":"ادخل عنوان";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        news_model.title = value!;
                      },
                    ),
                    TextFormField(
                     onFieldSubmitted: (_) {
                        FocusScope.of(context).autofocus(_imageUrlFocusNode);
                      },
                      initialValue: _initValues['desc'],
                      decoration: InputDecoration(labelText:EasyLocalization.of(context)!.currentLocale==Locale('en','')? 'Description':"الوصف"),
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                            return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter description":"ادخل وصف من فضلك";
                        }
                        if (value.length < 20) {
                            return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "'Should be at least 20 characters long.'":"يجب ان يكون على الاقل 30 حرف";
                        
                        }
                        return null;
                      },
                      onSaved: (value) {
                        news_model.desc = value!;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100.w,
                          height: 100.h,
                          margin: EdgeInsets.only(
                            top: 8.h,
                            right: 10.w,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.w,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Text("imgurl").tr()
                              : FittedBox(
                                  child: Image.network(
                                  _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            
                            decoration: InputDecoration(labelText:EasyLocalization.of(context)!.currentLocale==Locale('en','')? 'Image URL':"رابط الصوره"),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            validator: (value) {
                              EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Please enter an image URL":"ادخل رابط صوره من فضلك";
                              if (value!.isEmpty) {
                                return 'Please enter an image URL.';
                                
                              }

                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                  return   EasyLocalization.of(context)!.currentLocale==Locale('en','')?  'Please enter a valid image URL.':"ادخل رابط صوره صالح من فضلك";
                              
                              }
                              return null;
                            },
                            onSaved: (value) {
                              news_model.dateTime = DateTime.now();
                              news_model.imgurl = value!;
                            },
                          ),
                          
                        ),
                          
                      ],
                    ), Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: ElevatedButton(
style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
          onPressed: _saveForm, child: Text("Save",style: TextStyle(fontSize: 20.sp),).tr()),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
