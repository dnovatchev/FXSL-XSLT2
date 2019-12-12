<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:testmapTree-Fun="testmapTree-Fun" 
 exclude-result-prefixes="f testmapTree-Fun"
>
    <xsl:import href="../f/mapTree.xsl"/>
   
   <!-- This transformation must be applied to:
        numTree.xml 
    -->

    <testmapTree-Fun:testmapTree-Fun/>
    
    <xsl:output indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="/">
      <xsl:variable name="vFun" select="document('')/*/testmapTree-Fun:*[1]"/>
      
      <xsl:call-template name="mapTree">
	    <xsl:with-param name="pTree" select="/*"/>
	    <xsl:with-param name="pFun" select="$vFun"/>
      </xsl:call-template>
    </xsl:template>

    <xsl:template match="*[namespace-uri()='testmapTree-Fun']"
     mode="f:FXSL">
      <xsl:param name="arg1"/>
      
      <xsl:value-of select="2 * $arg1"/>
    </xsl:template>

</xsl:stylesheet>
