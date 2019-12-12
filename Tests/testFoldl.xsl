<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:msxsl="urn:schemas-microsoft-com:xslt"
xmlns:f="http://fxsl.sf.net/"
xmlns:foldr-func="foldr-func"
exclude-result-prefixes="f foldr-func"
>

   <xsl:import href="../f/foldl.xsl"/>

   <!-- This transformation must be applied to:
        numList.xml 
     -->
   <foldr-func:foldr-func/>
   <xsl:variable name="vFoldrFun" select="document('')/*/foldr-func:*[1]"/>
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">

      <xsl:call-template name="foldl">
        <xsl:with-param name="pFunc" select="$vFoldrFun"/>
        <xsl:with-param name="pList" select="/*/*"/>
        <xsl:with-param name="pA0" select="0"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template match="*[namespace-uri() = 'foldr-func']" mode="f:FXSL">
         <xsl:param name="arg1" select="0"/>
         <xsl:param name="arg2" select="0"/>
         
         <xsl:value-of select="$arg1 + $arg2"/>
    </xsl:template>

</xsl:stylesheet>
