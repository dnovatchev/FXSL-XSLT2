<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 >
  
  <xsl:import href="../f/func-arcTrignm.xsl" />

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:for-each select="1 to 10">
       <xsl:value-of select="f:arcsin(1 div ., 0.000001, 'deg')"/>
       <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>