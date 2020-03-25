<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
>
 <xsl:output method="text"/>
	<xsl:template match="/">
	  <xsl:call-template name="sum">
	    <xsl:with-param name="pFrom" select="1"/>
	    <xsl:with-param name="pTo" select="1000000"/>
	  </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="sum">
	  <xsl:param name="pAccumulated" as="xs:integer"
	       select="0"/>
	  <xsl:param name="pFrom" as="xs:integer"/>
	  <xsl:param name="pTo" as="xs:integer"/>
	  
	  <xsl:choose>
	    <xsl:when test="$pFrom gt $pTo">
	      <xsl:value-of select="$pAccumulated"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:call-template name="sum">
	        <xsl:with-param name="pAccumulated" 
	             select="$pAccumulated + $pFrom"/>
	        <xsl:with-param name="pFrom" select="$pFrom + 1"/>
	        <xsl:with-param name="pTo" select="$pTo"/>
	      </xsl:call-template>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:template>
</xsl:stylesheet>