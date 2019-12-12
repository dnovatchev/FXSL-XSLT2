
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:foldr-func="foldr-func"
exclude-result-prefixes="f foldr-func"
>

   <xsl:import href="../f/func-foldr.xsl"/>

   <!-- This transformation must be applied to:
        ../data/numList.xml 

        Expected result: 55
     -->

   <foldr-func:foldr-func/>
   <xsl:variable name="vFoldrFun" select="document('')/*/foldr-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">

      <xsl:value-of select="f:foldr($vFoldrFun, 0, /*/*)"/>
    </xsl:template>

    <xsl:template match="*[namespace-uri() = 'foldr-func']" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="$arg1 + $arg2"/>
    </xsl:template>

</xsl:stylesheet>
