<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:someTrue-Or="someTrue-Or"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs someTrue-Or"
>
  <xsl:import href="func-foldr.xsl"/>
  
  <xsl:function name="f:someTrue">
    <xsl:param name="pList" as="item()*"/>
    
    <xsl:variable name="vOr" select="document('')/*/someTrue-Or:*[1]"/>
    
    <xsl:value-of select="f:foldr($vOr, false(), $pList)"/>
  </xsl:function>
  
  <someTrue-Or:someTrue-Or/>

  <xsl:template name="Or" match="someTrue-Or:*" as="xs:boolean"
   mode="f:FXSL">
    <xsl:param name="arg1" as="xs:boolean"/>
    <xsl:param name="arg2"  as="xs:boolean"/>
    <xsl:sequence select="$arg1 or $arg2"/>
  </xsl:template>
</xsl:stylesheet>