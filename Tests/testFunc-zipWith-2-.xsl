<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myAdd="f:myAdd"
 exclude-result-prefixes="f myAdd"
>
  <xsl:import href="../f/func-zipWithDVC.xsl"/>
  <xsl:import href="../f/func-exp.xsl"/>

   <xsl:output  method="text"/>
   
   <xsl:template match="/">
    <xsl:value-of select="f:zipWith(f:pow(), 1 to 10, 1 to 10)" separator="&#xA;"/>
   </xsl:template>
</xsl:stylesheet>
