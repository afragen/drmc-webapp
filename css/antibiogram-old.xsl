<?xml version="1.0" encoding="UTF-8" ?>
<!--
	antibiogram
	Created by Andy Fragen on 2011-03-23.
	Copyright (c) 2011  All rights reserved.
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="utf-8" indent="yes" />

  <!-- Root template -->    
  <xsl:template match="/">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
  	<html>
  	  <head>
        <!-- <link rel="stylesheet" href="./css/antibiogram.css" type="text/css" media="screen" charset="utf-8"/> -->
        <meta name="viewport" content="width=device-width"/>
  	    <style type="text/css" media="screen">
  	     <![CDATA[
  	     td.gram_negative { color: red; }
         td.gram_positive { color: blue; }
         td.gram_negative, td.gram_positive { font-style:italic; }
         td { vertical-align:top; }
         input { margin: 1.5em 1em; }
         table#antibiotic-organism td.sens { padding-left:20px; }
         table#organism-antibiotic td.sens { width:50px; }
  	     ]]>
  	    </style>
  	    <script type="text/javascript" charset="utf-8">
  	     <![CDATA[
        function toggleId(obj) {
        	var el = document.getElementById(obj);
         	if ( el.style.display != 'none' ) {
         		el.style.display = 'none';
         	}
         	else {
         		el.style.display = '';
         	}
         }
         function toggleIds(obj_a, obj_b) {
         	var el1 = document.getElementById(obj_a);
         	var el2 = document.getElementById(obj_b);
          	if ( el1.style.display != 'none' ) {
          		el1.style.display = 'none';
          		el2.style.display = '';
          	}
          	else {
          		el1.style.display = '';
          		el2.style.display = 'none';
          	}
          }
         ]]>
  	    </script>
  	    <title><xsl:value-of select="antibiogram/title"/></title>
	    </head>
	      
	      <!-- Body -->
        <body>
          <h2><xsl:value-of select="antibiogram/title"/>:<br /><xsl:value-of select="antibiogram/date"/></h2>
          <!-- <input type="button" onClick="toggleId('organism');" value="Toggle Organism"  /> -->
          <xsl:call-template name="organismTable"/>
          <!-- <input type="button" onClick="toggleId('antibiotic');" value="Toggle Antibiotic"  /> -->
          <xsl:call-template name="antibioticTable"/>
        </body>
      </html>
	</xsl:template>
	  
  <!-- organismTable template -->
  <xsl:template name="organismTable">
      <table border="1" id="organism" class="organism">
        <tr><td colspan="3"><input type="button" onClick="toggleIds('organism','antibiotic');" value="Show Antibiotic"/></td></tr>
      	  <tr bgcolor="#9acd32">
            <!-- <th>Type</th> -->
            <th>Organism</th>
            <th>Isolates</th>
            <th>Antibiotic Sensitivity</th>
          </tr>
    	    <xsl:for-each select="antibiogram/organism">
         	<xsl:sort select="type" order="ascending"/>
   	      <xsl:variable name="stain"><xsl:value-of select="type"/></xsl:variable> 
    	      <xsl:variable name="bug"><xsl:value-of select="css"/></xsl:variable> 
              <tr id="{$bug}" class="{$stain}">
                <!-- <td><xsl:value-of select="type"/></td> -->
                <td class="{$stain}"><xsl:value-of select="name"/></td>
                <td style="text-align:center;"><xsl:value-of select="isolates"/></td>
                <td><xsl:call-template name="organism-antibioticTemplate"/></td>
              </tr>
            </xsl:for-each>
        </table>
  </xsl:template>
   
   <!-- organism-antibioticTemplate -->
   <xsl:template name="organism-antibioticTemplate">
          <table id="organism-antibiotic">
            <tr>
        	    <xsl:for-each select="antibiotic/name">
        	      <xsl:sort select="sensitivity" data-type="number" order="descending"/>
        	      <xsl:if test="sensitivity != ''"><!-- <xsl:if test="sensitivity != 0"> -->
        	      <tr>
                  <td><xsl:value-of select="value"/></td>
                  <td class="sens"><xsl:value-of select="sensitivity"/></td>
                </tr>
                </xsl:if><!-- </xsl:if> -->
              </xsl:for-each>
            </tr>
          </table>
   </xsl:template>
   
   <!-- antibioticTable template -->
   <xsl:template name="antibioticTable">
       <table border="1" id="antibiotic" class="antibiotic" style="display:none;">
         <tr><td colspan="2"><input type="button" onClick="toggleIds('organism','antibiotic');" value="Show Organism"/></td></tr>
       	  <tr bgcolor="#9acd32">
       	     <th>Antibiotic</th>
             <th>Organism Sensitivity</th>
           </tr>
     	    <xsl:for-each select="antibiogram/antibiotic">
    	      <xsl:variable name="bugjuice"><xsl:value-of select="css"/></xsl:variable> 
              <tr id="{$bugjuice}">
                  <td><xsl:value-of select="name"/></td>
               <td><xsl:call-template name="antibiotic-organismTemplate"/></td>
               </tr>
             </xsl:for-each>
         </table>
   </xsl:template>
   
   <!-- antibiotic-organismTemplate -->
   <xsl:template name="antibiotic-organismTemplate">
          <table id="antibiotic-organism">
            <tr>
        	    <xsl:for-each select="bacteria/name">
        	      <xsl:sort select="sensitivity" data-type="number" order="descending"/>
        	      <xsl:variable name="stain"><xsl:value-of select="type"/></xsl:variable> 
                <xsl:if test="sensitivity != ''"><!-- <xsl:if test="sensitivity != 0"> -->
                  <tr>
                    <td class="{$stain}"><xsl:value-of select="value"/></td>
                    <td class="sens"><xsl:value-of select="sensitivity"/></td>
                  </tr>
                </xsl:if><!-- </xsl:if> -->
              </xsl:for-each>
            </tr>
          </table>
   </xsl:template>

   
</xsl:stylesheet>
