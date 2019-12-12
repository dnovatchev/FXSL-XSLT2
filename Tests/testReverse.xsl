<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:import href="../f/reverse.xsl"/>
  
  <xsl:output method="text"/>
  
  <!-- To be applied on text.xml -->
  
  <xsl:template match="/">
    <xsl:call-template name="strReverse">
      <xsl:with-param name="pStr" select="/*"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
