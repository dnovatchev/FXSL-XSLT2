<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-str-reverse.xsl"/>
  <xsl:output method="text"/>
  <!-- To be applied on text.xml -->
  
  <xsl:template match="/">
    <xsl:value-of select="f:str-reverse(/*)"/>
  </xsl:template>
</xsl:stylesheet>
