<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:str-foldl-func="f:str-foldl-func"
exclude-result-prefixes="f str-foldl-func"
>

   <xsl:import href="../f/func-str-foldl.xsl"/>
 <!-- To be applied on any xml file -->

   <str-foldl-func:str-foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/str-foldl-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">
      <xsl:copy-of select="f:str-foldl($vFoldlFun, 0, '123456789')"/>
    </xsl:template>

    <xsl:template match="str-foldl-func:*" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="number($arg1) + number($arg2)"/>
    </xsl:template>

</xsl:stylesheet>
