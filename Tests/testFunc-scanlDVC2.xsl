<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-scanlDVC.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  <xsl:import href="../f/func-append.xsl"/>
  <xsl:import href="../f/func-zipWith.xsl"/>
  
  <!-- To be applied on runningTotalsPairwise.xml -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <xsl:template match="/">
    <xsl:sequence select=
    "f:zipWith(f:append(), 
               f:scanl1(f:add(), data(/*/*/@X)), 
               f:scanl1(f:add(), data(/*/*/@Y))
               )"/>
  </xsl:template>
  
</xsl:stylesheet>