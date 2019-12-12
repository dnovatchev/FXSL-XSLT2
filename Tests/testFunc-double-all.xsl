<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
   <xsl:import href="../f/func-doubleall.xsl"/>

   <!-- This transformation must be applied to:
        ../data/numList.xml 

        Expected result: 2, 4, 6, 8, 10, 12, 14, 16, 18, 20,
    -->
   
   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   
   <xsl:template match="/">
     <xsl:for-each select="f:doubleall(/*/*)">
       <xsl:value-of select="concat(., ', ')"/>
     </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>