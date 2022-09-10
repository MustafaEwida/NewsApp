

enum Gender{
male,
female

}

class UserMdoel {


  String get gen{
if(gender==Gender.female){
return "female";
}else{
return 'male';
}


  }
 
  String? id;
  String? name;//
  String? email;//
  DateTime? birth;
 String? password;//
 String? imgurl;
 

  String? gender;

UserMdoel({ this.password, this.birth,this.email,this.imgurl ,this.gender,  this.id,
this.name});
  
}