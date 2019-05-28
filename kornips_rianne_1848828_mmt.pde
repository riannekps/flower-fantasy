import processing.serial.*;
import cc.arduino.*;

Bloem bloem = new Bloem();
Bloem[] bloemen = new Bloem[9];
Arduino arduino;
PImage img;
int optie;
int potpin = 0; 
int ledpin = 3;
int linkspin = 4;
int rechtspin = 2;
int val = 0;
int gevoeligheid; //gevoeligheid van de draaiknop.
//int groeisnelheid; 
float potmeterverschil; //het verschil tussen het nieuwe potmeterwaarde en de oude waarde.
int verschil;//zorgt voor een smoother potmeterverschil
float potmeteroud; //de vorige waarde van de potmeter.
boolean ingedruktlinks, ingedruktrechts; //zorgt ervoor dat als je de knop inhoudt, de code maar een keer wordt uitgevoerd. 
boolean creeren; //true= je bent bezig met het creeren van de bloem, false = je ziet de betekenis van de bloem. 

void setup(){
  optie = 0; //begint bij optie 0
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  fullScreen();
  img = loadImage("img/nature.jpg");
  bloem.setup();
  
  for(int i = 0; i < bloemen.length; i++){
  bloemen[i] = new Bloem();
  bloemen[i].setup();
  }
  
  noCursor();
  potmeteroud = 0;
  gevoeligheid = 10;
  arduino.pinMode(ledpin, Arduino.OUTPUT);
  
  arduino.pinMode(linkspin, Arduino.INPUT);
  arduino.pinMode(rechtspin, Arduino.INPUT);
  arduino.pinMode(1, Arduino.INPUT);
  arduino.pinMode(11, Arduino.INPUT);
  
  creeren = true;
}

//lichtsensor: bekijkt hoeveel licht er op de lichtsensor valt en met deze gegvens gaat het lampje aan of uit. 
void lichtsensor(){
  val= arduino.analogRead(1);// read the analog value of the sensor and assign it to val Serial.println(val) | van pdf
  fill(0);
  if(val < 900){
    arduino.analogWrite(ledpin,255);// turn on the LED and set up brightness maximum output value
    if(creeren){
    if(bloem.stengel.aantal_T < bloem.stengel.aantal){
      bloem.stengel.aantal_T++;
      }
      else if(bloem.stengel.aantal_T > bloem.stengel.aantal){
        bloem.stengel.aantal_T--;
      }
    }
    else{
      for(int i = 0; i < bloemen.length; i++){
        if(bloemen[i].stengel.aantal_T < bloemen[i].stengel.aantal){
          bloemen[i].stengel.aantal_T++;
        }
      }
    }
  }
  else{
    arduino.analogWrite(ledpin,0);
    if(creeren){
      if(bloem.stengel.aantal_T > 3){
        bloem.stengel.aantal_T--;
      }
    }
    else{      
      for(int i = 0; i < bloemen.length; i++){
        if(bloemen[i].stengel.aantal_T > 3){
          bloemen[i].stengel.aantal_T--;
        }
      }
    }
  }
  delay(10); //wait for 0.01 seconds
}

void draw(){
  fill(215, 250, 255);
  rect(0,0, width, height);
  background(img);
  input();
  lichtsensor();
  
  if(creeren){
  creerenBloem();
  }
  else{
  betekenis();
  }
}
 
 void creerenBloem(){
   menu();
   fill(120, 210, 160);
   textSize(22);
   
   if(optie == 0){
     text("•", 60, 90);
     if(bloem.knop.preset > 0 && bloem.knop.preset < 4){
       gevoeligheid = 80;
       bloem.knop.preset += verschil;
     }
     if(bloem.knop.preset <= 0){
        bloem.knop.preset = 1;
     }
     else if(bloem.knop.preset >= 4){
       bloem.knop.preset = 3;
     }
   }
  
   else if(optie == 1){
     text("•", 60, 120);
      if(bloem.stengel.blad.preset > 0 && bloem.stengel.blad.preset < 3){
        gevoeligheid = 80;
        bloem.stengel.blad.preset += verschil;
    }
    if(bloem.stengel.blad.preset <= 0){
       bloem.stengel.blad.preset = 1;
    }
    else if(bloem.stengel.blad.preset >= 3){
       bloem.stengel.blad.preset = 2;
    }
  }
  
  else if(optie == 2){
    text("•", 60, 150);
    if(bloem.stengel.aantal > 2 && bloem.stengel.aantal < 15){
      gevoeligheid = 10;
      bloem.stengel.aantal += verschil;
    }
    if(bloem.stengel.aantal <= 2){
       bloem.stengel.aantal = 3;
    }
    else if(bloem.stengel.aantal >= 15){
       bloem.stengel.aantal = 14;
    }
  }
  else if(optie == 3){
    text("•", 60, 180);
      gevoeligheid = 10;
    if(bloem.knop.aantalBlad> 2 && bloem.knop.aantalBlad < bloem.knop.blaadjesMax){
    bloem.knop.aantalBlad += verschil;
    }
    if(bloem.knop.aantalBlad <= 2){
        bloem.knop.aantalBlad = 3;
    }
    else if(bloem.knop.aantalBlad >= bloem.knop.blaadjesMax){
     bloem.knop.aantalBlad = bloem.knop.blaadjesMax-1;      
   }
 }
 
  else if(optie == 4){
    text("•", 60, 210);
    if(bloem.knop.breedte> 10 && bloem.knop.breedte < 40){
      gevoeligheid = 10;
    bloem.knop.breedte += verschil*2;
    }
    if(bloem.knop.breedte <= 10){
       bloem.knop.breedte = 11;
    }
    else if(bloem.knop.breedte >= 40){
     bloem.knop.breedte = 39;      
    }
    
  }
  else if(optie == 5){
    text("•", 60, 240);
    gevoeligheid = 10;
    if(bloem.knop.lengte> 50 && bloem.knop.lengte < 160){
    bloem.knop.lengte += verschil*5;
    }
    if(bloem.knop.lengte <= 50){
       bloem.knop.lengte = 51;
    }
    else if(bloem.knop.lengte>= 160){
     bloem.knop.lengte = 159;      
    }
  }
  
  else if(optie == 6){
    text("•", 60, 270);
    gevoeligheid = 40;
    if(bloem.knop.kleurgeselecteerd >= 0 && bloem.knop.kleurgeselecteerd < 7 || verschil < 0 && bloem.knop.kleurgeselecteerd == 7){
    bloem.knop.kleurgeselecteerd += verschil;
    }
    if(bloem.knop.kleurgeselecteerd < 0){
       bloem.knop.kleurgeselecteerd = 0;
    }
    else if(bloem.knop.kleur1.rood >= 8){
     bloem.knop.kleurgeselecteerd = 7;      
   }
  }
  
  else if(optie >= 7 && optie <= 9){
    text("•", 60, 300);
    fill(0, 0, 0, 60);
    rect((width/2) -225, 50, 450, 50);
    fill(240);
    textSize(22);
    text("Druk nog " + (10 - optie) + " om je bloem af te maken",( width/2) - 200, 85);
    
  }
  else{
  creeren = false;
  }
  
  pushMatrix();
  translate(width/ 2, height - 5);
  bloem.draw();
  popMatrix();
 }

void betekenis(){
  for(int i = 0; i < bloemen.length; i++){
    pushMatrix();
    bloemen[i].edit(bloem.stengel.aantal, bloem.stengel.blad.preset, bloem.knop.lengte, bloem.knop.breedte, bloem.knop.aantalBlad, bloem.knop.preset, bloem.knop.kleurgeselecteerd);
    translate(70 + 150 * i, height-5);
    bloemen[i].draw();
    popMatrix();
    
  }
  fill(0,0,0,60);
  rect(width/2-425, 25, 850, 120);
  textSize(18);
  
  if(bloem.knop.kleurgeselecteerd == 0){
    fill(240);
    text("Je hebt gekozen voor een rode bloem. Rode bloemen staan voor passie, verleiding, romantiek, tederheid. Je bent een actief en daadkrachtig persoon en je houd van een rijke, luxe stijl.", width/2-396, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 1){
    fill(240);
    text("Je hebt gekozen voor een roze bloem. Roze bloemen staan voor onschuld, romantiek, zachtheid, blijdschap en tederheid. Je gaat positief door het leven en je bent een echte romanticus.", width/2-396, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 2){
    fill(240);
    text("Je hebt gekozen voor een paarse bloem. Paarse bloemen staan voor rouw en ernst, maar ook waardigheid en voorbereiding. Jij bent een persoon die erg gewaardeerd word en altijd op alles is voorbereid. ook ben je erg creatief, charmant en elegant.", width/2-396, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 3){
    fill(240);
    text("Je hebt gekozen voor een blauwe bloem. Blauwe bloemen staan voor goddelijkheid, eeuwigheid en onschuld. Je bent een kalm en rustig persoon en je bent altijd trouw/ loyaal.", width/2-396, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 4){
    fill(240);
    text("Je hebt gekozen voor een groene bloem. Groene bloemen staan voor jong leven, vruchtbaarheid, vrede, welvaart en hoop. Je bent een persoon die vrede houdt, je bent altijd vol hoop en je streeft naar welvaart.", width/2-395, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 5){
  fill(240);
  text("Je hebt gekozen voor een gele bloem. Gele bloemen staan voor energie kracht, groei, vrolijkheid, vreugde. Ook staat het voor warmte, zon en een nieuw begin. Jij houdt van de Lente en de start van een nieuw begin. Je bent een persoon die vreuge en vrolijkheid uitstraalt.", width/2-395, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 6){
  fill(240);
  text("Je hebt gekozen voor een oranje bloem. Oranje bloemen staan voor vrolijkheid, warmte, gezelligheid, optimisme, plezier, kracht, vitaliteit en energie. En ook voor aandacht, beweging, sportiviteit en feestelijkheid. jij bent een optimistisch persoon en je houdt van aandacht. Je zoekt naar avontuur en je zit altijd vol met energie.", width/2-395, 35, 800,110);
  }
  
  if(bloem.knop.kleurgeselecteerd == 7){
  fill(240);
  text("Je hebt gekozen voor een witte bloem. Witte bloemen staan voor puurheid, reinheid, frisheid, zuiverheid, helderheid en eenvoud. Maar ook voor onschuld, maagdelijkheid, volmaaktheid, natuurlijke liefde en vroomheid. Je bent een eerlijk persoon en je streeft naar perfectie. ", width/2-395, 35, 800,110);
  }
  
  if(optie >= 10 && optie <= 12){
    text("•", 60, 300);
    fill(0, 0, 0, 60);
    rect(5, 25, 250, 30);
    fill(240);
    textSize(12);
    text("Druk nog " + (13 - optie) + " om opnieuw te beginnen",25, 45);
    
  }
  else{
   reset(); 
   bloem.setup();
   optie = 0;
   creeren = true;
  }
}

void reset(){
  
}

//geeft het menu van opties weer
void menu(){
  fill(0, 0, 0, 60);
  rect(50, 50, 235, height-490);
  
  fill(240);
  textSize(22);
  text("Knop type", 80, 90);
  text("Stengel type", 80, 120);
  text("Stengel lengte", 80, 150);
  text("Aantal blaadjes", 80, 180);
  text("Breedte blaadjes", 80, 210);
  text("Lengte blaadjes", 80, 240);
  text("Kleur", 80, 270);
  fill(120, 210, 160);
  text("Klaar!", 80, 300);
}

//afhandelen van de input van de knoppen en de draaiknop
void input(){
   verschil = 0;
   float potmeter = arduino.analogRead(0);
   if(arduino.digitalRead(linkspin) == arduino.HIGH && optie > 0){
     if(!ingedruktlinks){
     optie--;
     ingedruktlinks = true;
     }
   }
    else{
      ingedruktlinks= false;
    }
    
   if(arduino.digitalRead(rechtspin) == arduino.HIGH){
     if(!ingedruktrechts){
     optie++;
     ingedruktrechts = true;
     }
   }
   else{
     ingedruktrechts = false;
   }
    
   potmeterverschil += (potmeter - potmeteroud)/gevoeligheid;
   
   if(potmeterverschil < -1){
     potmeterverschil = 0;
     verschil = -1;
   }
   else if(potmeterverschil > 1){
     potmeterverschil = 0;
     verschil = 1;
   }
   potmeteroud = potmeter;
   
}
