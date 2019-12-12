<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:MyTakeController="f:MyTakeController" 
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f MyTakeController"
>
  <xsl:import href="../f/func-str-takeWhile.xsl"/>
  <xsl:import href="../f/func-str-dropWhile.xsl"/>
  
  <!-- To be applied on test-str-takeWhile.xml -->
  
  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:variable name="vMyTakeController"
                  select="document('')/*/MyTakeController:*[1]"/>
    <xsl:value-of 
     select="f:str-takeWhile(/*, $vMyTakeController, '0123456789')"/>
    <xsl:value-of select="'&lt;===>'"/>

    <xsl:value-of select=
      "f:str-dropWhile(/*, $vMyTakeController, '0123456789')"/>
  </xsl:template>
  
  <MyTakeController:MyTakeController/>
  <xsl:template match="MyTakeController:*" mode="f:FXSL">
  	<xsl:param name="arg1" select="''"/>
    <xsl:param name="arg2" select="/.."/>
    
    <xsl:value-of select="number(contains(string($arg2), string($arg1)))"/>
  </xsl:template>
</xsl:stylesheet>
