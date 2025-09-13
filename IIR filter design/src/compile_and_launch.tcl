proc vsimulink {args} {

  lappend sllibarg -foreign \{simlinkserver \{C:/Program Files/MATLAB/R2024b/toolbox/edalink/extensions/modelsim/windows32/liblfmhdls_gcc421vc12.dll\}
  if {[catch {lsearch -exact $args -socket} idx]==0  && $idx >= 0} {
    set socket [lindex $args [expr {$idx + 1}]]
    set args [lreplace $args $idx [expr {$idx + 1}]]
    append socketarg " \; -socket " "$socket"
    lappend sllibarg $socketarg
  }
  set runmode "Batch"
  if { $runmode == "Batch" || $runmode == "Batch with Xterm"} {
    lappend sllibarg " \; -batch"
  }
  lappend sllibarg \}
  set args [linsert $args 0 vsim]
  lappend args [join $sllibarg]
  uplevel 1 [join $args]
}
proc vsimmatlab {args} {

  lappend mllibarg -foreign \{matlabclient \{C:/Program Files/MATLAB/R2024b/toolbox/edalink/extensions/modelsim/windows32/liblfmhdlc_gcc421vc12.dll\}
  lappend mllibarg \}
  lappend mlinput 
  lappend mlinput [join $args]
  lappend mlinput [join $mllibarg]
   set mlinput [linsert $mlinput 0 vsim]
  uplevel 1 [join $mlinput]
}
proc vsimmatlabsysobj {args} {

  lappend sllibarg -foreign \{matlabsysobjserver \{C:/Program Files/MATLAB/R2024b/toolbox/edalink/extensions/modelsim/windows32/liblfmhdls_gcc421vc12.dll\}
  if {[catch {lsearch -exact $args -socket} idx]==0  && $idx >= 0} {
    set socket [lindex $args [expr {$idx + 1}]]
    set args [lreplace $args $idx [expr {$idx + 1}]]
    append socketarg " \; -socket " "$socket"
    lappend sllibarg $socketarg
  }
  set runmode "Batch"
  if { $runmode == "Batch" || $runmode == "Batch with Xterm"} {
    lappend sllibarg " \; -batch"
  }
  lappend sllibarg \}
  set args [linsert $args 0 vsim]
  lappend args [join $sllibarg]
  uplevel 1 [join $args]
}
onElabError {echo "Loading simulation and HDL Verifier library failed."; quit -f}
transcript file "tpf0e658e9_6542_4242_b9cf_7a1e936ca3cd.log"
if { [catch {vsimulink butterworth -t 1ns -voptargs=+acc   } errmsg] } {
    echo "Loading simulation and HDL Verifier library failed."; 
    echo $errmsg; 
    quit -f; 
}

