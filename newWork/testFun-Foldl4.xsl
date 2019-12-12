<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:foldl-func="f:foldl-func"
exclude-result-prefixes="f foldl-func"
>

   <xsl:import href="../f/func-foldl.xsl"/>

   <!-- This transformation must be applied to:
        complexSum.xml 
     -->
   <foldl-func:foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/foldl-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">

      <xsl:value-of 
       select="f:foldl($vFoldlFun,
                         0,
                         /*/ItemList/Item
                                 [@Id 
                                 = 
                                  /*/AddValues/ItemToAdd/@Id
                                 ]
                         )"/>
    </xsl:template>

    <xsl:template match="foldl-func:*" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of 
         select="$arg1 + $arg2/@Cost * $arg2/@Qty"/>
    </xsl:template>

</xsl:stylesheet>
