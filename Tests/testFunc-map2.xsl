<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
   <xsl:import href="../f/func-map.xsl"/>
   <xsl:import href="../f/func-Operators.xsl"/>
   
<!--
    This transformation must be applied to:           
        ../data/numList.xml                           
                                                      
        Expected result: 2,4,6,8,10,12,14,16,18,20,   
-->

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:template match="/">
     <xsl:for-each select="f:map(f:mult(2), 1 to 10)">
       <xsl:value-of select="concat(.,',')"/>
     </xsl:for-each>
   </xsl:template>
</xsl:stylesheet>