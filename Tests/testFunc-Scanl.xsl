<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
  exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-scanl.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  
  <!-- To be applied on numList.xml -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>

  <xsl:template match="/">
   
    <xsl:for-each select="f:scanl(f:add(), 0, /*/*)">
      <xsl:value-of select="concat(., ', ')"/>
    </xsl:for-each>
       
    <xsl:text>&#xA;- - - - - - - - - - -&#xA;</xsl:text>
    
     <xsl:for-each select="f:scanl1(f:add(), /*/*)">
      <xsl:value-of select="concat(., ', ')"/>
     </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>