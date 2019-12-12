<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-drop.xsl"/>
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="/">
    <xsl:copy-of select="f:drop(3, /*/*)"/>
  </xsl:template>
</xsl:stylesheet>
