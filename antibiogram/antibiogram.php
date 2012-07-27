<?php
 header('Content-Type: text/html');
 //error_reporting(E_ALL ^ E_NOTICE);
 $y = '';
 if(isset($_GET['year'])) $y = $_GET['year'];
 if ($y > 2011 || $y < 2010) {
   $current_year=date("Y");
   $strtotime=strtotime($current_year);
   $last_year=strtotime("-1 year",$strtotime);
   $y = date("Y",$last_year);
 }
 $xml = new DOMDocument();
 $xml->load('./DRMCAntibiogram_' . $y . '.xml');
 
 $xsl = new DOMDocument;
 $xsl->load('../css/antibiogram.xsl');
 
 $proc = new XSLTProcessor();
 $proc->importStyleSheet($xsl);
 
 echo $proc->transformToXML($xml);

?>