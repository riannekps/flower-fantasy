class Knop{
  int lengte;
  int breedte;
  Kleur kleur1 = new Kleur(); //kleur van de blaadjes van de bloemen
  Kleur kleur2= new Kleur(); //kleur van het rondje in de knop
  Kleur kleur3 = new Kleur(); //de kleur van de knop van preset 3
  Kleur[] kleuren = new Kleur[8];
  int aantalBlad;
  int blaadjesMax;
  int preset;
  int kleurgeselecteerd;
  
  void setup(){
    kleuren[0] = new Kleur();
    kleuren[0].update(235,75,55);
    kleuren[1] = new Kleur();
    kleuren[1].update(235,65,130);
    kleuren[2] = new Kleur();
    kleuren[2].update(190,80,235);
    kleuren[3] = new Kleur();
    kleuren[3].update(90,145,235);
    kleuren[4] = new Kleur();
    kleuren[4].update(90,235,90);
    kleuren[5] = new Kleur();
    kleuren[5].update(230,235,95);
    kleuren[6] = new Kleur();
    kleuren[6].update(235,170,80);
    kleuren[7] = new Kleur();
    kleuren[7].update(245,245,245);
    
    kleurgeselecteerd = 0;
     
    kleur2.update(255, 245, 150);
    
    lengte = 50;
    breedte = 30;
    aantalBlad = 10;
    preset= 1;
  }
  
  void draw(){
    translate(5,0);
    int afstand = 4 * aantalBlad;
    if(preset == 3){
      blaadjesMax = 10;
      fill(kleur3.rood, kleur3.groen, kleur3.blauw);
      circle(0,0,35+ aantalBlad*3);
  }
  else {
    rotate(radians((360/ aantalBlad)/2));
  }
    for(int i = 0; i < aantalBlad; i++){
      fill(kleuren[kleurgeselecteerd].rood, kleuren[kleurgeselecteerd].groen + sin(i*10) * 20, kleuren[kleurgeselecteerd].blauw);
      
      if(preset == 1){
      rotate(radians(360/ aantalBlad));
      ellipse(10 + lengte/2, 0, lengte ,breedte);
    }
     else if(preset == 2){
      rotate(radians(360/ aantalBlad));
      circle(0, breedte/2,breedte);
      triangle(-breedte/2, breedte/2, 0, lengte, breedte/2, breedte/2);
     }
     else if(preset == 3){
       pushMatrix();
       translate(0, -aantalBlad);
       if(i != aantalBlad -1 || aantalBlad%2 == 0){
         if(i%2 == 0){
           rotate(radians(afstand/2));
         ellipse(afstand, -lengte/2, breedte,-lengte);
         }
         else{
           rotate(radians(-afstand/2));
           ellipse(-afstand, -lengte/2, breedte,-lengte);
           afstand -= 10;
         }
       }
       if(i == aantalBlad - 1 && aantalBlad%2 == 1){
         ellipse(0, -lengte/2, breedte,-lengte);
       }
       popMatrix();
       }
    }
    if(preset == 1 || preset == 2){
      blaadjesMax = 15;
        fill(kleur2.rood, kleur2.groen, kleur2.blauw);
        circle(0,0,25);
    }  
  }
}
