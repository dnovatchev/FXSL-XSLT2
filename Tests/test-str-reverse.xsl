<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

   <xsl:import href="../f/strReverse.xsl"/>

   <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

   <xsl:template match="/">
     <xsl:call-template name="strReverse">
       <xsl:with-param name="pStr" select="'abracadabra'"/>
     </xsl:call-template>
   </xsl:template>
</xsl:stylesheet>
