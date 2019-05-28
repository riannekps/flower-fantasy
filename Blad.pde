//de blaadjes van de stengel
class Blad{
  int lengte;
  int breedte;
  int preset = 0;
  
  void setup(){
    lengte = 50;
    breedte = 10; 
    
  }
  
  void draw(int richting){
    pushMatrix();
    translate(10, 0);
    rotate(radians(-45 * richting));
    rect(0,0, lengte * richting, breedte,20);
    if(preset == 2){
      fill(240, 240, 240);
      circle((lengte * richting)-5, 0, 10); 
    }
    popMatrix();
  }
}
