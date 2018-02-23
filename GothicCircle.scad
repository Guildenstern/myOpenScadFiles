$fn=30;

module Kreisfenster(R,W,H,O)
{
  O = 3; //only support for 3, yet
  phi=45;
  largeOuter=R;
  largeInner=largeOuter-W;
  smallOuter=R/2.154;
  smallInner=smallOuter-W;
 
  translateFactor = largeOuter-smallOuter-W/2; 
  
  
  linear_extrude(H)
  {
    difference()
    {
      circle(largeOuter);
      circle(largeInner);
    }
  
    translate([0,translateFactor,0])
    {
      difference()
      {
        circle(smallOuter);
        circle(smallInner);
      }
    }
    
    translate([-smallOuter+W/2,-translateFactor*0.5,0])
    {
      difference()
      {
        circle(smallOuter);
        circle(smallInner);
      }
    }

    translate([+smallOuter-W/2,-translateFactor*0.5,0])
    {
      difference()
      {
        circle(smallOuter);
        circle(smallInner);
      }
    }

  } //extrude
}

Kreisfenster(200, 20, 10, 3);
