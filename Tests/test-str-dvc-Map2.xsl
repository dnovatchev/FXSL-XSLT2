<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:testmap="testmap"
exclude-result-prefixes="f testmap"
>
   <xsl:import href="../f/str-dvc-map.xsl"/>
   
   <!-- To be applied on numList.xml -->
   
   <testmap:testmap/>

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
   <xsl:template match="/">
     <xsl:variable name="vTestMap" select="document('')/*/testmap:*[1]"/>
     <xsl:call-template name="str-map">
       <xsl:with-param name="pFun" select="$vTestMap"/>
       <xsl:with-param name="pStr" select="string(/*)"/>
     </xsl:call-template>
   </xsl:template>

    <xsl:template name="indentNL" match="*[namespace-uri() = 'testmap']"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      
      <xsl:value-of select="$arg1"/>
      <xsl:if test="$arg1='&#10;'">
        <xsl:value-of select="'    '"/>
      </xsl:if>
    </xsl:template>

</xsl:stylesheet>
