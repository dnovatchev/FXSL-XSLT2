<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myIsAlpha="f:myIsAlpha"
  exclude-result-prefixes="f myIsAlpha"
>
 
  <xsl:import href="../f/func-str-filterDVC.xsl"/>
  
  <!-- To be applied on testFilter90K.xml file -->
  <!-- Compare this with Mike Kay's ingenious solution:
      testDoubleTranslate.xsl -->
 
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    <xsl:variable name="vIsAlpha" select="document('')/*/myIsAlpha:*[1]"/>
    
    Filtering by IsAlpha: 
    
    filter('A1b3C67DE+', IsAlpha) = 
     <xsl:value-of select="f:str-filter(/*, $vIsAlpha)"/>
   </xsl:template>
  
  <xsl:variable name="vUpper" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'"/>
  <xsl:variable name="vLower" select="'abcdefghijklmnopqrstuvwxyz'"/>
  <xsl:variable name="vAlpha" select="concat($vUpper, $vLower)"/>
  
  <myIsAlpha:myIsAlpha/>
  <xsl:template name="myIsAlpha" match="myIsAlpha:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    <xsl:value-of select="number(contains($vAlpha, $arg1))"/>
  </xsl:template>
</xsl:stylesheet>
