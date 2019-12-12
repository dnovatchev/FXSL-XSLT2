<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:testmap="testmap"
exclude-result-prefixes="f testmap"
>
   <xsl:import href="../f/str-map.xsl"/>
   
   <!-- to be applied on any xml source -->
   
   <testmap:testmap/>

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
   <xsl:template match="/">
     <xsl:variable name="vTestMap" select="document('')/*/testmap:*[1]"/>
     <xsl:call-template name="str-map">
       <xsl:with-param name="pFun" select="$vTestMap"/>
       <xsl:with-param name="pStr" select="'0123456789'"/>
     </xsl:call-template>
   </xsl:template>

    <xsl:template name="double" match="*[namespace-uri() = 'testmap']"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      
      <xsl:value-of select="2 * number($arg1)"/>
    </xsl:template>

</xsl:stylesheet>
