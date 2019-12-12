<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:import href="../f/multiIntegrate.xsl"/>
  
  <xsl:output method="text"/>

  <!-- To be applied on IntegrationList2.xml -->
  <xsl:template match="/">
    <xsl:variable name="vResult">
	    <xsl:call-template name="multiIntegrate">
	      <xsl:with-param name="pList" select="/*/*"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:value-of select="4 * $vResult"/>
  </xsl:template>
  
</xsl:stylesheet>
