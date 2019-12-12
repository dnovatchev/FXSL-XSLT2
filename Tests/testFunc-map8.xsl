<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f xs"
>
   <xsl:import href="../f/func-map.xsl"/>
   <xsl:import href="../f/func-Operators.xsl"/>
   <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
   
<!--
    This transformation must be applied to:           
        ../data/numList.xml                           
                                                      
        Expected result: 20   
-->

   <xsl:strip-space elements="*"/>

   <xsl:output omit-xml-declaration="yes" indent="yes"/>
   <xsl:strip-space elements="*"/>
   
   <xsl:template match="/">
     <xsl:value-of select="sum(f:map(f:string-length(), /*/node()))"/>
   </xsl:template>
</xsl:stylesheet>