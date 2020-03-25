<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 >
 <xsl:output method="text"/>
	<xsl:template match="/">
	  <xsl:sequence select="f:sum(0, 1, 1000000)"/>
	</xsl:template>
	
	<xsl:function name="f:sum">
	  <xsl:param name="pAccumulated" as="xs:integer"/>
	  <xsl:param name="pFrom" as="xs:integer"/>
	  <xsl:param name="pTo" as="xs:integer"/>
	  
	  <xsl:choose>
	    <xsl:when test="$pFrom gt $pTo">
	      <xsl:sequence select="$pAccumulated"/>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:sequence select="f:sum($pAccumulated + $pFrom,$pFrom + 1,$pTo)"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:function>
</xsl:stylesheet>