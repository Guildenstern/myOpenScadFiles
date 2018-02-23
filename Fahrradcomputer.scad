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



module hook(wd, hd, rd){
wh = 1.5*w;
union(){
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

translate([offset,0,w]){
    hook(15, 100, 2);
}


translate([2+s/2,-t+0.5,hs+4]){
  rotate([90,0,0]){
    pillow(w/2,20,w/2);
  }
}

mirror(){
    translate([offset,0,w]){
        hook(15, 100, 2);
    }
    translate([2+s/2,-t+0.5,hs+4]){
  rotate([90,0,0]){
    pillow(w/2,20,w/2);
  }
}
}

}


rotate([45,0,0]){
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


translate([13,-60,64.5]){
  support(15,2,7.5);
}

translate([-13-15,-60,64.5]){
  support(15,2,7.5);
}
