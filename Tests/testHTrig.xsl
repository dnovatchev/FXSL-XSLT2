<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="../f/hyper-trignm.xsl"/>
 <!-- To be applied on any xml file -->
  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:call-template name="hcos">
      <xsl:with-param name="pX" select="1"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
