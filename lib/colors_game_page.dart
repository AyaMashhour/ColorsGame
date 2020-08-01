import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Question {
  final String title;
  final Color color;
  final List<Option> options;
  Question(this.title,  this.color,this.options,);
}

class Option {
  final String text;
  final bool isCorrectAnswer;
  Option(this.text, [this.isCorrectAnswer=false]);
}


class ColorsGamePage extends StatefulWidget {
  @override
  _ColorsGamePageState createState() => _ColorsGamePageState();
}

class _ColorsGamePageState extends State<ColorsGamePage> {
  int _currentQuestion =0;
  int _currentScore=0;


  _onOptionClicked( bool isCorrectAnswer) {
    if(isCorrectAnswer) _currentScore++;{
      print(_currentScore);
    }
    setState(() {
      _currentQuestion++;
    });
    print('$_currentQuestion');
  }

  playAgain(){
    setState(() {
      _currentQuestion=0;
      _currentScore=0;


  });

}

  List<Question> _questionList = [
    Question(' احمر' ,Colors.yellow,
        [
          Option('احمر '),
          Option('اخضر '),
          Option('اصفر ',true),
          Option('برتقالى '),
          Option('ازرق '),
          Option('اسود ',),
        ]),
    Question(' ازرق ' ,Colors.black,

        [
          Option('احمر '),
          Option('اخضر '),
          Option('اصفر '),
          Option('برتقالى '),
          Option('ازرق '),
          Option('اسود ' ,true)
        ]),
    Question(' اخضر',Colors.orange,
        [
          Option('احمر '),
          Option('اخضر '),
          Option('اصفر '),
          Option('برتقالى ',true),
          Option('ازرق '),
          Option('اسود '),
        ]),
    Question(' برتقالى',Colors.red,
        [
          Option('احمر ',true),
          Option('اخضر '),
          Option('اصفر '),
          Option('برتقالى '),
          Option('ازرق '),
          Option('اسود',),
        ]),
    Question(' اخضر',Colors.blue,
        [
          Option('احمر ',),
          Option('اخضر '),
          Option('اصفر '),
          Option('برتقالى '),
          Option('ازرق ',true),
          Option('اسود '),
        ]),
    Question(' اصفر',Colors.green,
        [
          Option('احمر '),
          Option('اخضر ',true),
          Option('اصفر '),
          Option('برتقالى '),
          Option('ازرق '),
          Option('اسود '),
        ]),
  ];

  @override
  Widget build(BuildContext context) {

    List<Widget> options=[] ;
    if(_currentQuestion< _questionList.length)

    options=    _questionList[_currentQuestion].options.map((option) {
      return OptionWidget(
        option: option,
        onClicked:_onOptionClicked
      );
    }).toList();
    options.shuffle();

    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text(
          'احزر لون الكلمه ',
        ),
      ),
      body:_currentQuestion<_questionList.length? Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Text(
            'اختر لون الكلمة التالية',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          QuestionText(
            title: _questionList[_currentQuestion].title,

            textColor: _questionList[_currentQuestion].color,
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(child: GridView.count(crossAxisCount: 3, children: options))
        ],
      ):GameOver(_currentScore, _questionList.length,playAgain)
    );
  }
}
class  GameOver extends StatelessWidget {
  final int _currentScore;
  final int _questionSize;
  final  Function playAgain;

  const GameOver( this._currentScore, this._questionSize,this.playAgain);



  @override
  Widget build(BuildContext context) {
    Icon _icon=Icon(Icons.cancel);
    String recentMsg='كل اجابتك خاطئه';

 switch(_currentScore){
   case 0:
     {
       _icon = Icon(Icons.cancel,color: Colors.red,size: 70,);
       recentMsg = 'اغلب اجابتك خاطئه';
       break;
     }
   case 1:{
     _icon = Icon(Icons.cancel,color: Colors.red,size: 70,);
     recentMsg = 'اغلب اجابتك خاطئه';
     break;
   }
   case 2:{
     _icon = Icon(Icons.error,color: Colors.red,size: 70,);
     recentMsg ='اغلب اجابتك خاطئه ';
     break;
   }
   case 3:{
     _icon = Icon(Icons.error,color: Colors.yellow,size: 70,);
     recentMsg = 'بعض اجابتك خاطئه';
     break;
   }
   case 4:{
     _icon = Icon(Icons.check_circle,color: Colors.yellow,size: 70,);
     recentMsg = 'اغلب  اجابتك صحيحه';
     break;
   }
   case 5:{
     _icon = Icon(Icons.check_circle,color: Colors.green,size: 70,);
     recentMsg = ' كل اجابتك صحيحه';
     break;
   }
   case 6:{
     _icon = Icon(Icons.check_circle,color: Colors.green,size: 70,);
     recentMsg = 'كل اجابتك صحيحه ';
     break;
   }




 }

    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
          _icon,

            Text("انتهت اللعبه  ",style: TextStyle(fontSize:20 ,fontWeight: FontWeight.bold),),
            Text(' $recentMsg ($_currentScore/$_questionSize)',style: TextStyle(fontSize:20 ,color: Colors.blue),),
            RaisedButton(onPressed: playAgain,child: Text('اعد المحاولة'),)
          ],
        ),
      ),
    );
  }
}


class QuestionText extends StatelessWidget {

  final String title;
  final Color textColor;

  const QuestionText({
    this.title,
    this.textColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          color: textColor, fontWeight: FontWeight.bold, fontSize: 25),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final Option option;
  final Function(bool) onClicked;
  OptionWidget({this.option, this.onClicked});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        onClicked(option.isCorrectAnswer);

      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          option.text,//textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        color: Colors.white,
        margin: EdgeInsets.all(8),
      ),
    );
  }
}



