$fn = 100;


h = 85;
b = 86;
t = 22;
hs = 22; //schraege

w = 3; //wall

module puter(){
  translate([-b/2, -t/2, -h/2]){
    difference() {
      cube([b, t, h ]);
      polyhedron( points=[
        [0,0,0], //0
        [b,0,0], //1
        [b,t,0], //2
        [0,t,0], //3
       
        [0,0,hs],//4
        [b,0,hs] //5
        ],
    faces=[
        [0,1,2,3], //Boden
        [4,0,3], //links
        [1,5,2], //rechts
        [0,4,5,1],//vorne
        [2,5,4,3]
        ]); 
   }
 }
}

s = 30; //slit
module case(){ 
    translate([0,-t/2,t+hs]){
    difference(){
        difference(){
        {  
        minkowski(){
            puter();
            sphere(d=4);
            }
        puter();          
        }
        translate([-s/2, -(t+2*w)/2, -hs+0.5*w]){
            cube([s, w, h]);}
        };
    translate([-b/2, -t/2, (h/2)]){
      cube([b,t,w]);
    }
    }
    }
}


module hook_finn_bare(wd, hd, slit)
{
    o = 0.5*wd;
  translate([o-0.25*wd,-0.5*w,0.25*hd]){ cube([0.5*wd, 2*w, 0.5*hd]); }
  translate([o-0.30*wd,-0.5*w,0.25*hd]){ cube([0.6*wd, 0.5*w, 0.5*hd]); }
  if(slit == true){
    translate([o-0.25*wd,-0.5*w,-10]){ cube([0.5*wd, 2*w, 0.5*hd]); }
    translate([o-0.30*wd,-0.5*w,-10]){ cube([0.6*wd, 0.5*w, 0.5*hd]); }
  }
}

module hook_finn(wd, hd, slit)
{
  if(slit == true)
  {
    minkowski(){
      hook_finn_bare(wd,hd,slit);
      cube([0.2,0.2,0.2]);
    }
  }
  else
  {
    hook_finn_bare(wd,hd,slit);
  }
}


module hook_mount(wd, hd, rd){
  //mounting part
  wh = 1.5*w;
  difference(){
  difference(){ union(){
    translate([0,-w,0.04*hd]) { cube([wd,1.5*w,0.75*hd]); } //long part of the hook 
    translate([0,-w,0.04*hd]) {rotate([0,90,0]){ cylinder(wd,wh,wh); }}
    translate([0,-w,79]) {rotate([0,90,0]){ cylinder(wd,wh,wh); }}
  }
  translate([-1,-3*w,-10]) { cube([wd+2,2*w,hd]); }
  }
  hook_finn(wd,hd, true);
  }
}
      

module hook_hook(wd, hd, rd){
wh = 1.5*w;
union(){
  translate([0,1, 0]){
  translate([0,rd+wh, hd]){
    rotate([0,90,0]){
      difference(){
        cylinder(wd,rd+wh,rd+wh);
        cylinder(wd,rd,rd);  
        translate([0, -rd, 0]){
          cube([rd+wd,2*rd+wd,wd]);         
        }
     }
    }
  }
  cube([wd,1.5*w,hd]); //long part of the hook
  translate([0,wh/2,0]){
        rotate([0,90,0]){
            cylinder(wd,wh/2,wh/2);
          }
      }
  shortLen = 2*wh;
  translate([0, 2*rd+wh, hd-shortLen]){
    union(){
      cube([wd,1.5*w,shortLen]); //short part of the hook
      translate([0,wh/2,0]){
        rotate([0,90,0]){
            cylinder(wd,wh/2,wh/2);
          }
        }
      }
    }
  }
  hook_finn(wd,hd, false);

  }
  
}

module hook(wd,hd,rd)
{
  hook_mount(wd,hd,rd);
  //hook_hook(wd,hd,rd);
  
}

module pillow(b,l,t){
  minkowski(){
    cube([b,l,t/2]);
    sphere(d=t/2);   
  }
}


module fertig()
{

case();
offset = 13;

translate([offset,w,w]){
    hook(15, 100, 2);
}


translate([2+s/2,-t+0.5,hs+4]){
  rotate([90,0,0]){
    pillow(w/2,20,w);
  }
}

mirror(){
    translate([offset,w,w]){
        hook(15, 100, 2);
    }
    translate([2+s/2,-t+0.5,hs+4]){
  rotate([90,0,0]){
    pillow(w/2,20,w);
  }
}
}

}


rotate([45,0,0])
{
  fertig();
}

module support(b,h,t)
{
  difference(){
    cube([b,h,t]);
    s =1;
    for(i=[0:s:b])
    {
      translate([i,0,0]){
        cube([s-0.2,2,t/3]);
      }
      translate([i,0,t-1.5]){
        cube([s-0.2,2,t/3]);
      }
    }
  }
}

