<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:func-transform="f:func-transform"
exclude-result-prefixes="f func-transform"
>
   <xsl:import href="../f/transform-and-sum.xsl"/>

   <!-- to be applied on testTransform-and-sum1.xml -->

   <xsl:output method="text"/>
   
   <func-transform:func-transform/>

    <xsl:template match="/">
      <xsl:call-template name="transform-and-sum">
        <xsl:with-param name="pFuncTransform" 
                        select="document('')/*/func-transform:*[1]"/>
        <xsl:with-param name="pList" select="/*/*"/>
      </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="func-transform:*" mode="f:FXSL">
      <xsl:param name="arg" select="0"/>
      <xsl:value-of select="translate($arg, ',', '')"/>
    </xsl:template>

</xsl:stylesheet>
