<?xml version="1.0" encoding="UTF-8" ?>
<!--
	shortage
	Created by Andy Fragen on 2011-04-07.
	Copyright (c) 2011 All rights reserved.
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output encoding="UTF-8" indent="yes" method="text" />

	<xsl:template match="/">
	  <xsl:for-each select="shortage/antibiotic">
	    <xsl:if test="available = 'no'">
	      <xsl:text>.</xsl:text><xsl:value-of select="css"/><xsl:text> {text-decoration:line-through;}&#13;</xsl:text>
      </xsl:if>
    </xsl:for-each>
	  
	</xsl:template>
</xsl:stylesheet>
