<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:mySquare="f:mySquare" 
 xmlns:myDouble="f:myDouble"
 exclude-result-prefixes="f mySquare myDouble"
 >
  
  <xsl:import href="../f/randomList.xsl"/>
  
  <!-- Can be applied on any source xml document (ignored) -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <xsl:template match="/">
    <xsl:call-template name="randomizeList">
      <xsl:with-param name="pList" select="1  to 10"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>