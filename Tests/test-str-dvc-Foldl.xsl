<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:dvc-foldl-func="dvc-foldl-func"
exclude-result-prefixes="f dvc-foldl-func"
>

   <xsl:import href="../f/dvc-str-foldl.xsl"/>

   <dvc-foldl-func:dvc-foldl-func/>
   <xsl:variable name="vFoldlFun" select="document('')/*/dvc-foldl-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">

      <xsl:call-template name="dvc-str-foldl">
        <xsl:with-param name="pFunc" select="$vFoldlFun"/>
        <xsl:with-param name="pStr" select="'123456789'"/>
        <xsl:with-param name="pA0" select="0"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template match="dvc-foldl-func:*" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="number($arg1) + number($arg2)"/>
    </xsl:template>

</xsl:stylesheet>
