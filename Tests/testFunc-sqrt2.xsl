<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f" 
 >
  <xsl:import href="../f/func-sqrt.xsl"/>
  
  <!-- To be applied on any source xml. 
       This also tests the within() function 
  -->
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  

 <xsl:template match="/*" name="initial">
   <xsl:value-of select="f:sqrt(13, 0.1)"/>
  </xsl:template>
</xsl:stylesheet>
