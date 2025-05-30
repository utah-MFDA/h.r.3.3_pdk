
function is_valid_orient(direction) = (direction == "N" ||
  direction == "S" ||
  direction == "W" ||
  direction == "E" ||
  direction == "FN" ||
  direction == "FS" ||
  direction == "FW" ||
  direction == "FE" ||
  direction == "R0" ||
  direction == "R90" ||
  direction == "R180" ||
  direction == "R270" ||
  direction == "MX" || // mirror X
  direction == "MY" || // mirror Y
  direction == "MX90" ||
  direction == "MY90"
  ?true:false) ;

module lefdef_orient(direction, center=[0,0], size=[0,0]) {
  module centertranslate() {
    if (center[0] != 0 || center[1] != 0) {
      if (size[0] > 0 || size[1] > 0)
        echo("Both center and size defined, center wins") ;

      translate([center[0], center[1], 0])
        children() ;
    }
    else if (size[0] > 0 || size[1] > 0) {
      translate([size[0]/2, size[1]/2, 0])
        children() ;
    }
    else {
      children() ;
    }
  } // end center translate

  if (direction == "N" || direction == "R0") {
    centertranslate() 
      children() ;
  }
  else if (direction == "S" || direction == "R180") {
    centertranslate() 
    rotate(180)
      children() ;
  }
  else if (direction == "FN" || direction == "MX") {
    centertranslate() 
    mirror([1,0,0])
      children() ;
  }
  else if (direction == "FS" || direction == "MY") {
    centertranslate() 
    mirror([0,1,0])
      children() ;
  }
  else if (direction == "W" || direction == "R180") {
    centertranslate() 
    rotate(90)
      children() ;
  }
  else if (direction == "E" || direction == "R180") {
    centertranslate() 
    rotate(270)
      children() ;
  }
  else if (direction == "FW" || direction == "MX90") {
    centertranslate() 
    mirror([1,0,0])
    rotate(90) 
      children() ;
  }
  else if (direction == "FE" || direction == "MY90") {
    centertranslate() 
    mirror([0,1,0])
    rotate(90)
      children() ;
  }
  else {
    echo("Invalid orientation for lefdef_orient ", direction) ;
    children() ;
  }
}
