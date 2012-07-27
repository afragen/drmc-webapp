<!DOCTYPE html>
<html manifest="../manifest.php">

<head>
<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />
<link href="../css/style.css" rel="stylesheet" media="screen" type="text/css" />
<link rel="stylesheet" href="../css/drmc.css" type="text/css" media="screen" />
<link rel="apple-touch-icon" href="../images/apple-touch-icon.png" />
<script src="../javascript/functions.js" type="text/javascript"></script>
<title>DRMC Antibiograms</title>
<meta content="DRMC, Antibiograms, antibiotic" name="keywords" />
<meta content="DRMC Antibiograms" name="description" />
</head>

<body>

<div id="topbar">
	<div id="title">DRMC Antibiograms</div>
	  <div id="leftnav">
    	<a href="../index.php"><img alt="home" src="../images/home.png" /></a>
      </div>

</div>
<div id="content">

<?php
$default_dir = "./"; // lists files only for the directory which this script is run from


function file_ext_strip($filename) {
    return preg_replace('/\.[^.]*$/', '', $filename);
}

function find_year($filename) {
	preg_match('/(?<!\d)\d{4}(?!\d)/i', $filename, $match);
	return ($match[0]);
}

function list_directory($dir) {
	$narray=array();
	$dir_handle = @opendir($dir) or die("Unable to open $dir");
	$i=0;
	$skip_files = array(".", "..", ".htaccess", "index.php", "antibiogram.php", "DRMCAntibiogramTemplate.xml");
	while($file = readdir($dir_handle)) {
		if(!in_array($file, $skip_files)) {
			$narray[$i]=$file;
			$i++;
		}
	}
	rsort($narray); // case-insensitive sort
	return $narray;
	closedir($dir_handle); //closing the directory
}

// print out html
echo "\t" . '<ul class="pageitem">' . "\r\n\t";
$directory_array = list_directory($default_dir);
for($i=0; $i<sizeof($directory_array); $i++) {
	echo '<li class="menu"><a href='.chr(34) . "./antibiogram.php?year=" . find_year($directory_array[$i]) .chr(34). ">" . '<span class="name">DRMC Antibiogram ' . find_year($directory_array[$i]) . '</span><span class="arrow"></span></a> </li>' . "\r\n\t";
}
echo "</ul>";
?>

</div>
<div id="footer">
	<!-- Support iWebKit by sending us traffic; please keep this footer on your page, consider it a thank you for our work :-) -->
	<a class="noeffect" href="http://iwebkit.net">Powered by iWebKit</a></div>

</body>

</html>
