<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:func-transform="f:func-transform"
exclude-result-prefixes="f func-transform"
>
   <xsl:import href="../f/func-transform-and-sum.xsl"/>

   <!-- to be applied on testTransform-and-sum3.xml -->
   
   <xsl:output method="text"/>
   
    <xsl:template match="/">
     <xsl:value-of select=
     "f:transform-and-sum(document('')/*/func-transform:*[1], 
                          //freespace)
     "/>
    </xsl:template>
    
    <func-transform:func-transform/>
    <xsl:template match="func-transform:*" mode="f:FXSL">
      <xsl:param name="arg1" select="0"/>
      <xsl:value-of select="substring-before($arg1, ' ')"/>
    </xsl:template>
</xsl:stylesheet>
