<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myDropController="f:mymyDropController" 
exclude-result-prefixes="f myDropController"
>
  <xsl:import href="../f/func-str-dropWhile.xsl"/>
  
  <xsl:output method="text"/>

  <xsl:variable name="vTab" select="'&#9;'"/>
  <xsl:variable name="vNL" select="'&#10;'"/>
  <xsl:variable name="vCR" select="'&#13;'"/>
  <xsl:variable name="vWhitespace" 
                select="concat(' ', $vTab, $vNL, $vCR)"/>
  
  <xsl:template match="/">
    <xsl:variable name="vFunController" 
                  select="document('')/*/myDropController:*[1]"/>
           
      <xsl:variable name="pStr" select="concat('  ', $vTab, $vCR, $vNL,
                                               'Some   Text',
                                               $vNL, $vTab, '   ',$vCR
                                               )"/>
    
    '<xsl:sequence 
     select="f:str-dropWhile($pStr, $vFunController, $vWhitespace)"/>'
  </xsl:template>
  
  <myDropController:myDropController/>
  <xsl:template match="myDropController:*" mode="f:FXSL">
    <xsl:param name="arg1"/> <!-- The current char -->
    <xsl:param name="arg2"/> <!-- The controller params -->
    
    <xsl:value-of select="number(contains($arg2, $arg1))"/>
  </xsl:template>
</xsl:stylesheet>
