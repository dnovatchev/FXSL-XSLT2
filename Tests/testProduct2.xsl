<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:import href="../f/product.xsl"/>

     <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>
    
    <!-- To be applied on salesMap.xml -->
    
    <xsl:template match="/">

      <xsl:call-template name="product">
        <xsl:with-param name="pList" select="/sales/sale[1]/*"/>
      </xsl:call-template>
    </xsl:template>


</xsl:stylesheet>
