<?xml version="1.0" encoding="UTF-8" ?>
<!--
	antibiogram
	Created by Andy Fragen on 2011-03-23.
	Copyright (c) 2011  All rights reserved.
-->

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" doctype-system="legacy-compat"/>

  <!-- Root template -->
  <xsl:template match="/">
    <html manifest="../cache.manifest">
  	  <head>
        <meta content="yes" name="apple-mobile-web-app-capable" />
        <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
        <meta content="minimum-scale=1.0, width=device-width, maximum-scale=0.6667, user-scalable=no" name="viewport" />
        <link href="../css/style.css" rel="stylesheet" media="screen" type="text/css" />
        <link rel="stylesheet" href="../css/shortage.php" type="text/css" media="screen" charset="utf-8"/>
        <!-- <link media="only screen and (max-device-width: 480px)" href="../css/iPhone.css" type="text/css" rel="stylesheet" /> -->
        <link rel="apple-touch-icon" href="../images/apple-touch-icon.png" />
        <script src="../javascript/functions.js" type="text/javascript"></script>
        <meta content="Antibiogram" name="Antibiogram" />
  	    <style type="text/css" media="screen">
  	     <![CDATA[
  	     td.gram_negative { color: red; }
         td.gram_positive { color: blue; }
         td.gram_negative, td.gram_positive { font-style:italic; }
         td { vertical-align:top; }
         input { margin: 1.5em 1em; }
         td { text-align:left;}
         table#organism-antibiotic td.sens, table#antibiotic-organism td.sens { text-align:right;  }
         table#antibiotic td.spacer { width: 53px; }
         table#organism, table#antibiotic { width:300px; }
         table#organism-antibiotic, table#antibiotic-organism { width: 100% }
         table.center { margin-left:auto; margin-right:auto; }
         th, td {font-size:0.9em;}
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
          <div id="topbar">
            <div id="title">Antibiogram</div>
            <div id="leftnav">
              <a href="../index.php"><img alt="home" src="../images/home.png" /></a>
              <a href="index.php">&#8656;</a>
            </div>
          </div>
          <div id="content">
            <span class="graytitle"><xsl:value-of select="antibiogram/title"/>: <xsl:value-of select="antibiogram/date"/></span>
            <ul class="pageitem">
              <li>
           <!-- <input type="button" onClick="toggleId('organism');" value="Toggle Organism"  /> -->
              <xsl:call-template name="organismTable"/>
              <!-- <input type="button" onClick="toggleId('antibiotic');" value="Toggle Antibiotic"  /> -->
              <xsl:call-template name="antibioticTable"/>
              </li>
            </ul>
          </div>
          <div id="footer">
          	<!-- Support iWebKit by sending us traffic; please keep this footer on your page, consider it a thank you for our work :-) -->
          	<a class="noeffect" href="http://iwebkit.net">Powered by iWebKit</a>
          </div>

      </body>
      </html>
	</xsl:template>

  <!-- organismTable template -->
  <xsl:template name="organismTable">
      <table border="1" id="organism" class="organism center">
        <tr><td colspan="3"><input type="button" onClick="toggleIds('organism','antibiotic');" value="Show Antibiotic"/></td></tr>
      	  <tr bgcolor="#9acd32">
            <!-- <th>Type</th> -->
            <th>Organism</th>
            <th>Isolates</th>
            <th>Antibiotic/Sensitivity</th>
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
              <xsl:variable name="bugjuice"><xsl:value-of select="css"/></xsl:variable>
        	    <xsl:if test="sensitivity != ''"><!-- <xsl:if test="sensitivity != 0"> -->
        	    <tr>
                  <td class="{$bugjuice}"><xsl:value-of select="value"/></td>
                  <td class="sens"><xsl:value-of select="sensitivity"/></td>
                </tr>
                </xsl:if><!-- </xsl:if> -->
              </xsl:for-each>
            </tr>
          </table>
   </xsl:template>

   <!-- antibioticTable template -->
   <xsl:template name="antibioticTable">
       <table border="1" id="antibiotic" class="antibiotic center" style="display:none;">
         <tr><td colspan="3"><input type="button" onClick="toggleIds('organism','antibiotic');" value="Show Organism"/></td></tr>
       	  <tr bgcolor="#9acd32">
       	     <th>Antibiotic</th>
       	     <th></th>
             <th>Organism/Sensitivity</th>
           </tr>
     	    <xsl:for-each select="antibiogram/antibiotic">
    	      <xsl:variable name="bugjuice"><xsl:value-of select="css"/></xsl:variable>
              <tr>
                 <td class="{$bugjuice}"><xsl:value-of select="name"/></td>
                 <td class="spacer"><xsl:text disable-output-escaping="yes">&#160;</xsl:text></td>
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
