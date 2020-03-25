<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema">
 <xsl:output method="text"/>
 
 <xsl:template match="/*">
   <xsl:perform-sort select="*/xs:integer(.)">
     <xsl:sort select="."/>
   </xsl:perform-sort>
 </xsl:template>
</xsl:stylesheet>