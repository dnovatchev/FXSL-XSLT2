<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:str-foldl-func="f:str-foldl-func"
exclude-result-prefixes="f str-foldl-func"
>

   <xsl:import href="../f/str-foldl.xsl"/>
 <!-- To be applied on any xml file -->

   <str-foldl-func:str-foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/str-foldl-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">

      <xsl:call-template name="str-foldl">
        <xsl:with-param name="pFunc" select="$vFoldlFun"/>
        <xsl:with-param name="pStr" select="'123456789'"/>
        <xsl:with-param name="pA0" select="0"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template match="str-foldl-func:*" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="number($arg1) + number($arg2)"/>
    </xsl:template>

</xsl:stylesheet>
