import 'package:flutter/material.dart';
import 'constants.dart';

class Symptoms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Covid19 India Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 5,),
                  Text('COVID-19 affects different people in different ways. Most infected people will develop mild to moderate illness and recover without hospitalization.',
                  overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: cTitle(Colors.black),
                    maxLines:6,
                  ),
                  SizedBox(height: 5,),
                  Text('Most common symptoms:\n * fever\n * dry cough\n * tiredness',
                    overflow: TextOverflow.ellipsis,
                    style: cTitle(Colors.black),
                    //textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 5,),
                  Text('Less common symptoms:\n * aches and pains\n * sore throat\n * diarrhoea\n * conjunctivitis\n * headache\n * loss of taste or smell\n * a rash on skin, or discolouration of fingers',
                    overflow: TextOverflow.ellipsis,
                    style: cTitle(Colors.black),
                    //textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5,),
                  Text('Serious symptoms:\n * difficulty breathing\n * chest pain or pressure\n * loss of speech or movement',
                    overflow: TextOverflow.ellipsis,
                    style: cTitle(Colors.black),
                    //textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 5,),
                  Text('Seek immediate medical attention if you have serious symptoms. Always call before visiting your doctor or health facility.',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: cTitle(Colors.black),
                    maxLines:6,
                  ),
                  SizedBox(height: 5,),
                  Text('People with mild symptoms who are otherwise healthy should manage their symptoms at home.',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: cTitle(Colors.black),
                    maxLines:2,
                  ),
                  SizedBox(height: 5,),
                  Text('On average it takes 5-6 days from when someone is infected with the virus for symptoms to show, however it can take up to 14 days.',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: cTitle(Colors.black),
                    maxLines:6,
                  ),
                  SizedBox(height: 5,),
                  Text('STAY HOME STAY SAFE',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: cTitle(Colors.red),
                  ),
                  SizedBox(height: 5,),
                  Text('Source: World Health Organization',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: cTitle(Colors.black26),
                  ),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
