<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:func-transform2="f:func-transform2"
exclude-result-prefixes="f func-transform2"
>
   <xsl:import href="../f/func-transform-and-sum.xsl"/>
   <xsl:import href="../f/func-hex-to-decimal.xsl"/>

   <!-- to be applied on testTransform-and-sum2.xml -->
   
   <xsl:output method="text"/>
   
    <xsl:template match="/">
      <xsl:value-of select=
      "f:transform-and-sum(document('')/*/func-transform2:*[1], /*/*)"/>
    </xsl:template>
    
    <func-transform2:func-transform2/>
    <xsl:template match="func-transform2:*" mode="f:FXSL">
      <xsl:param name="arg1"/>
      <xsl:value-of select="f:hex-to-decimal($arg1)"/>
    </xsl:template>
</xsl:stylesheet>