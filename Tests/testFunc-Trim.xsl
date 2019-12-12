<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f" 
>

  <xsl:import href="../f/func-trim.xsl"/>

  <!-- to be applied on trim.xml -->
  
  <xsl:output method="text"/>
  <xsl:template match="/">
    '<xsl:value-of select="f:trim(string(/*))"/>'
  </xsl:template>
</xsl:stylesheet>
