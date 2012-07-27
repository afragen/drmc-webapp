<!DOCTYPE html>
<html manifest="manifest.php">

<head>

<?php 

function confirm($msg, $isMobile)
{
  if ($isMobile == true) {
  echo "<script type=\"text/javascript\">
  function standalone() {
  if(window.navigator.standalone) {
  }
  else {alert(\"$msg\")}}
  window.addEventListener(\"load\",standalone, false)</script>";
  } else {
    echo "<script type=\"text/javascript\">  
  window.alert(\"$msg\")
  </script>";
  }
}
function ip_in_network($ip, $net_addr, $net_mask){ 
  if($net_mask <= 0){ return false; } 
    $ip_binary_string = sprintf("%032b",ip2long($ip)); 
    $net_binary_string = sprintf("%032b",ip2long($net_addr)); 
    return (substr_compare($ip_binary_string,$net_binary_string,0,$net_mask) === 0); 
} 
$homescreen="Please add this page to your homescreen to view the custom icon, startup screen, and full screen mode.";
//$ip=@$REMOTE_ADDR;
$ip=$_SERVER['REMOTE_ADDR'];
// $my_ip="<b>IP Address = $ip</b>" . "\r\n<br />";

// echo ip_in_network($ip,$net_addr,16);
if (ip_in_network($ip,"67.98.222.0",24) == 1) {
	$loc="You're on the DRMC network. You need to tell everyone you know, especially in Administration, that this application by Dr. Fragen is ingenious.";
} elseif (ip_in_network($ip,"65.60.85.32",27) == 1) {
  $loc="You're on the DRMCGuest network. Be sure to tell everyone in Administration this application by Dr. Fragen is ingenious.";
} else {
  $loc="You're out and about.";
}

if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"iphone") || strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"ipad")) {
  if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"safari")) {
    $device='Running in iOS browser.';
    confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device . "\\r\\n" . $homescreen, true);
  // }else{
  //   $device='Running as stand alone WebApp on iPhone';
  //   confirm($loc . "\\r\\n" . $device);
  }
}elseif (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"android")) {
    $device='Running in browser on Android.';
    confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device . "\\r\\n" . $homescreen, true);
}else{
  // echo('<br />Running in browser.');
  $device='Running in browser. This was designed to run on handhelds.';
  confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device, false);
}
?>

<meta content="yes" name="apple-mobile-web-app-capable" />
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />
<meta name="format-detection" content="telephone=yes" />
<link href="./css/style.css" rel="stylesheet" media="screen" type="text/css" />
<link rel="stylesheet" href="./css/drmc.css" type="text/css" media="screen" />
<link rel="apple-touch-icon" href="./images/apple-touch-icon.png" />
<script src="./javascript/functions.js" type="text/javascript"></script>
<title>DRMC</title>
<meta content="antibiogram dictation coding scip" name="keywords" />
<meta content="DRMC Webapps" name="description" />
</head>

<body>

<div id="topbar">
  <div id="title">DRMC Webapps</div>
</div>
<div id="content">
  <ul class="pageitem">
     <li class="menu"><a href="./antibiogram/index.php"><span class="name">DRMC Antibiogram</span><span class="arrow"></span></a></li>
     <li class="menu"><a href="./scip/index.html"><span class="name">SCIP Information</span><span class="arrow"></span></a></li>
     <li class="menu"><a href="./dictate/index.html"><span class="name">Dictation &amp; Coding</span><span class="arrow"></span></a></li>
     
  </ul>
  <ul class="pageitem">
  	<li class="textbox">These webapps are available for offline usage on the appropriate device. They are provided by Dr. Andrew Fragen. Please let DRMC Administration (760.323.6778) know that you find this application ingenious.<div class="small pad_top"><a href="mailto:afragen@dtsurgeons.com">Feedback is appreciated.</a></div></li>
  </ul>
  
  
</div>
<div id="footer">
	<!-- Support iWebKit by sending us traffic; please keep this footer on your page, consider it a thank you for our work :-) -->
	<a class="noeffect" href="http://iwebkit.net">Powered by iWebKit</a></div>

</body>

</html>
