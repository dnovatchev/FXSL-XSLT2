<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-split.xsl"/>
  
  <!-- To be applied on numList.xml -->
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    Split 4
    <xsl:value-of select="f:split(/*/*, 4)"/>
  </xsl:template>
</xsl:stylesheet>
