<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:import href="../f/arcTrignm.xsl" />

  <xsl:output method="text"/>

  <xsl:template match="/">
    <xsl:call-template name="arccos">
      <xsl:with-param name="pX" select="0.5"/>
      <xsl:with-param name="pUnit" select="'deg'"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>