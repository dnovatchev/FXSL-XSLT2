<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
exclude-result-prefixes="f xs"
>
  <xsl:import href="../f/func-someTrue.xsl"/>
 
   <!-- This transformation must be applied to:
        boolNodes.xml 
     -->
  <xsl:output omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    <xsl:variable name="someTrue" select="f:someTrue(/*/*)" as="xs:boolean"/>
    
    <xsl:value-of select="$someTrue"/>
    <xsl:choose>
	    <xsl:when test="not($someTrue)">
	      <xsl:text>None are true</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>Some are true</xsl:text>
	    </xsl:otherwise>
    </xsl:choose>
    
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
    
    <xsl:text>&#xA;</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>

