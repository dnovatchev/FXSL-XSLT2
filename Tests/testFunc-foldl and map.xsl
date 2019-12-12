<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>

   <xsl:import href="../f/func-foldl.xsl"/>
   <xsl:import href="../f/func-map.xsl"/>
   <xsl:import href="../f/func-zipWithDVC.xsl"/>
   <xsl:import href="../f/func-Operators.xsl"/>
   <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
   <xsl:import href="../f/func-flip.xsl"/>
   <xsl:import href="../f/func-compose.xsl"/>

<!--
    This transformation must be applied to:  
        ../data/testFunc-Foldl and Map.xml   
                                             
        Expected result: 65.94000000000001   
-->
    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

    <xsl:template match="/">
      <xsl:value-of select=
      "f:foldl(f:add(), 0, f:zipWith(f:mult(),/*/*/@price, /*/*/@qty))"/>
 
--------------

<xsl:text/>    
                       
      <xsl:value-of select=
      "f:foldl(f:add(), 
               0,
               f:map(f:liftMult(f:flip(f:attribute(),'price'), 
                                f:flip(f:attribute(),'qty')
                                ),
                     /*/*
                     )
               )"/>

    </xsl:template>
    
</xsl:stylesheet>