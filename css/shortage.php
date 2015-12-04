<?php
 header('Content-Type: text/css');
$xml = new DOMDocument();
$xml->load('AntibioticShortage.xml');

$xsl = new DOMDocument;
$xsl->load('shortage.xsl');

$proc = new XSLTProcessor();
$proc->importStyleSheet($xsl);

echo $proc->transformToXML($xml);
