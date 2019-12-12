<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://fxsl.sf.net/"
  exclude-result-prefixes="f" 
 >
 
 <xsl:import href="../f/func-iter.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>

 <!-- To be applied on any xml file -->
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <xsl:template match="/">
  
    <xsl:value-of select="f:scanIter(9, f:add(3), 1)" separator=", "/>
  </xsl:template>
 
</xsl:stylesheet>