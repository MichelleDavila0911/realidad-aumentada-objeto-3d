import processing.video.*;
import jp.nyatla.nyar4psg.*;
import saito.objloader.*;
// We define several objects:
// A camera, a multimarker and a 3D model
Capture myCam;
MultiMarker myMarkers;
OBJModel model;

void setup() {

size(640,480,P3D);

colorMode(RGB, 100);

myCam=new Capture(this,640,480);
 myCam.start(); 

myMarkers=new MultiMarker(this,width,height,"camera_para.dat",NyAR4PsgConfig.CONFIG_PSG);

myMarkers.addARMarker("patt.hiro",80);
myMarkers.addARMarker("patt.kanji",80);

model = new OBJModel(this, "capitan2.obj");

model.scale(20);
model.translateToCenter();
model.enableTexture();
}
// The infinite loop
void draw()
{

if (myCam.available() !=true) {
return;
}

myCam.read();

myMarkers.detect(myCam);

background(0);

myMarkers.drawBackground(myCam);

for(int i=0;i<2;i++){
if((!myMarkers.isExistMarker(i))){
continue;
}

myMarkers.beginTransform(i);
translate(0,0,20);
scale(0.1);

model.draw();
myMarkers.endTransform();
}
}
