<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-hex-to-decimal.xsl"/>
  
  <!-- To be applied on ../data/hexNum.xml 

       Expected result: 2575
  -->
  
  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:value-of select="f:hex-to-decimal(/*/*[1])"/>
  </xsl:template>
</xsl:stylesheet>
