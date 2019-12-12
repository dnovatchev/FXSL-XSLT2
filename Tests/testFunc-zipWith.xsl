<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-zipWithDVC.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  
  <!-- To be applied on numList.xml -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="/">
    <xsl:for-each select=
    "f:zipWith(f:add(), (/*/*)[position() &lt; 6], (/*/*)[position() > 5])" 
    >
      <xsl:value-of select="concat(.,',')"/>
    </xsl:for-each>   
  </xsl:template>
</xsl:stylesheet>