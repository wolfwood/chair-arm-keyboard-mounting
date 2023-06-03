use <tryadactyl/assembly/util.scad>;
use <tryadactyl/util.scad>;

x1 = 89;
x2 = 164.75;

y1 = 101;
y2 = 140;

z=7;

pos = [//[0, 0, z],
       //[x1, 0, z],
       //[x2, 0, z],
       [0, y1, z],
       [x1, y2, z],
       [x2, y1, z]
       ];

foot_dia=11;
screw_head=8;
foot_h = 7;
spacer=3;
mounts = [ for (i = pos) absolute_screw_mounting_params(placement=i, screw_dia=4.20,
							strut_dia=screw_head, footroom=[foot_dia-screw_head,foot_h-spacer],
							washer_dia=5, spacer=spacer
							, headroom=[10.5-5,1]
							)];

module blank(i) {
  intersection(){
    mount_bounding_box(z=0,thickness = 3, mounting_params=i);
    screw_mounting(mounting_params=i, clearance=false,blank=true);
  }
}

module bounded_hull_stipulated(sets=[]) {
  for(set=sets){
    hull() for(i=set) {
      children(i);
    }
  }
}

//bar_magnetize_below(position=[-51,0,0])
//bar_magnetize_below(position=[51,0,0])
//bar_magnetize_below(position=[-6,44.5,0])
bar_magnetize_below(position=[x1-x2/2-2.5,(y2-y1)/4+3+y1/2,0],rotation=[0,0,90])
translate([-x2/2,-y1/2,0]) {

  apply_screw_mountings(mounts)
    bounded_hull_stipulated(sets=[[0,1],[1,2],[0,2]]) {
    blank(mounts[0]);
    blank(mounts[1]);
    blank(mounts[2]);
    //blank(mounts[3]);
    //blank(mounts[4]);
    //blank(mounts[5]);
  }

  *for (i=mounts) {

  }
}
