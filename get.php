<?php
$pathtofile = "cam.txt";
echo  exec('tail -n 1 '.$pathtofile);
?>