<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:foldl-func="foldl-func"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f foldl-func"
>

   <xsl:import href="../f/func-foldl.xsl"/>

<!--
    This transformation must be applied to:  
        ../data/numList.xml                  
                                             
        Expected result: 3628800 or 3.6288E6 
-->
   <foldl-func:foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/foldl-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">
      <xsl:value-of select="f:foldl($vFoldlFun, 1, 1 to 10 )"/>
    </xsl:template>
    
    <xsl:template match="*[namespace-uri() = 'foldl-func']"
     mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="$arg1 * $arg2"/>
    </xsl:template>

</xsl:stylesheet>