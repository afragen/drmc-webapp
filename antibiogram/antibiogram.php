<?php
 //libxml_disable_entity_loader( true);
 header('Content-Type: text/html');
 //error_reporting(E_ALL ^ E_NOTICE);
 $y = null;
 if ( isset( $_GET['year'] ) ) { $y = (int) $_GET['year']; }
 if ($y > 2020 || $y < 2010) { exit; }

 $xml = new DOMDocument();
 if ( isset( $xml->doctype ) ) { exit; }
 $xml->load('./DRMCAntibiogram_' . $y . '.xml');
 
 $xsl = new DOMDocument;
 $xsl->load('../css/antibiogram.xsl');
 
 $proc = new XSLTProcessor();
 $proc->importStyleSheet( $xsl );
 
 echo $proc->transformToXML( $xml );
