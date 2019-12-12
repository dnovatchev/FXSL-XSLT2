<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="../f/trim.xsl"/>

  <!-- to be applied on trim.xml -->
  
  <xsl:output method="text"/>
  <xsl:template match="/">
    '<xsl:call-template name="trim">
        <xsl:with-param name="pStr" select="string(/*)"/>
    </xsl:call-template>'
  </xsl:template>
</xsl:stylesheet>
