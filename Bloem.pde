class Bloem{
  Stengel stengel = new Stengel();
  Knop knop = new Knop();
  void setup(){
    stengel.setup();
    knop.setup();
  }
  
  void draw(){
    stengel.draw();
    knop.kleur3.update(stengel.kleur1.rood + stengel.aantal_T * 5, stengel.kleur1.groen + stengel.aantal_T * 10, stengel.kleur1.blauw + stengel.aantal_T * 7);
    knop.draw();
  }
  
  //edit alle belangrijke gegevens van een bloem tegelijkertijd
  void edit(int stengel_aantal_t, int stengel_preset_t, int knop_lengte_t, int knop_breedte_t, int knop_aantalBlad_t, int knop_preset_t, int knop_kleurgeselecteerd_t){
     stengel.aantal = stengel_aantal_t;
     stengel.blad.preset = stengel_preset_t;
     knop.lengte = knop_lengte_t;
     knop.breedte = knop_breedte_t;
     knop.aantalBlad = knop_aantalBlad_t;
     knop.preset = knop_preset_t;
     knop.kleurgeselecteerd = knop_kleurgeselecteerd_t;
  }
}
