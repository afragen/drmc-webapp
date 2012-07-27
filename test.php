<!DOCTYPE html>
<html>

<head>
<title>IP and UserAgent</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta name="viewport" content="width=device-width">
</head>
<body>

<?php 
date_default_timezone_set('America/Los_Angeles');
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
// echo "<b>IP Address = $ip</b>" . "\r\n<br />";
$my_ip="<b>IP Address = $ip</b>" . "\r\n<br />";
// echo $my_ip;

// echo ip_in_network($ip,$net_addr,16);
if (ip_in_network($ip,"67.98.222.0",24) == 1) {
	$loc="You're on the DRMC network. You need to tell everyone you know, especially in Administration, that this application by Dr. Fragen is ingenious.";
} elseif (ip_in_network($ip,"65.60.85.32",27) == 1) {
  $loc="You're on the DRMCGuest network.";
} else {
  $loc="You're out and about.";
}

// echo $loc;

if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"iphone") || strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"ipad")) {
   if (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"safari")) {
      // echo('<br />Running in browser on iPhone or iPad');
      $device='Running in iOS browser.';
      confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device . "\\r\\n" . $homescreen, true);
   // }else{
      // echo('<br />Running as stand alone WebApp on iPhone');
      // $device='Running as stand alone WebApp on iPhone';
      // confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device);
   }
}elseif (strpos(strtolower($_SERVER['HTTP_USER_AGENT']),"android")) {
   $device='Running in browser on Android.';
   confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device . "\\r\\n" . $homescreen, true);
}else {
   // echo('<br />Running in browser.');
   $device='Running in browser. This was designed to run on handhelds.';
   confirm($ip . "\\r\\n" . $loc . "\\r\\n" . $device, false);
}

echo date(DATE_RFC822) . "\r\n<br />";
echo $my_ip;
echo $_SERVER['HTTP_USER_AGENT'] . "\r\n<br />";

?>

</body>
</html>