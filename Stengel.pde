class Stengel{
  int aantal;
  int aantal_T;
  float lengte;
  float tijd; //de tijd hoelang het programma aantal. sinus maakt hier gebruik van om een golfbeweging te creeren.
  Kleur kleur1 = new Kleur();
  Blad blad = new Blad(); 
  
  void setup(){
    lengte = 50;
    aantal = 6;
    aantal_T = aantal; 
    tijd = 0;
    kleur1.update(30,120,80);
    blad.setup();
  }
  
  void draw(){
    
    blad.setup();
    noStroke();
    
    for(int i = 0; i < aantal_T; i++){
      rotate(radians((sin(tijd/100)*2)+(sin((tijd+i*50)/50)*5)));
      fill(kleur1.rood + i * 5, kleur1.groen + i * 10, kleur1.blauw + i * 7);
      rect(0,8,20-i,-lengte, 500);
      int richting = -1;
      if(i%2 == 0){ //% kijkt of het een even of oneven getal is
        richting = 1;
      }
      blad.lengte -= 3;
      blad.breedte -= 1;
      blad.draw(richting);
      translate(0,-(lengte-15));
      }
    tijd++;
   }
}
