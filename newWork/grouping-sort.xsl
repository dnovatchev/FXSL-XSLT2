<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema">
 <xsl:output method="text"/>

 <xsl:template match="/*">
   <xsl:for-each-group select=
     "*/xs:integer(.)" group-by=".">
    <xsl:sort select="current-grouping-key()"/>
    
    <xsl:copy-of select="current-group()"/>
   </xsl:for-each-group>
 </xsl:template>
</xsl:stylesheet>