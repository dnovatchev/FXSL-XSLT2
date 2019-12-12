<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>

   <xsl:import href="../f/func-foldl.xsl"/>
   <xsl:import href="../f/func-Operators.xsl"/>

<!--
    This transformation must be applied to:  
        ../data/numList.xml                  
                                             
        Expected result: 3628800 or 3.6288E6 
-->
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">
      <xsl:value-of select="f:foldl(f:mult(), 1, 1 to 10 )"/>
    </xsl:template>
    
</xsl:stylesheet>