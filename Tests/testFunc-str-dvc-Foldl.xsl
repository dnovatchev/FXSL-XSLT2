<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:dvc-foldl-func="dvc-foldl-func"
exclude-result-prefixes="f dvc-foldl-func"
>

   <xsl:import href="../f/func-dvc-str-foldl.xsl"/>

   <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

   <dvc-foldl-func:dvc-foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/dvc-foldl-func:*[1]"/>

    <xsl:template match="/">
      <xsl:value-of select="f:str-foldl($vFoldlFun, 0, '123456789')"/>
    </xsl:template>

    <xsl:template match="dvc-foldl-func:*" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="number($arg1) + number($arg2)"/>
    </xsl:template>

</xsl:stylesheet>
