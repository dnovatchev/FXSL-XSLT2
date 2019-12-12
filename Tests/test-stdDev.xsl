<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 >
 
 <xsl:import href="../f/stdDev.xsl"/>

 <!-- To be applied on numList.xml -->
 
 <xsl:output method="text"/>

  <xsl:template match="/">
   <xsl:call-template name="stdDev">
     <xsl:with-param name="pNums" select="/*/*"/>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
