<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-Operators.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>
 <xsl:import href="../f/func-pick.xsl"/>
 <xsl:import href="../f/func-map.xsl"/>
 
 <xsl:output method="text"/>
 
 <xsl:template match="/">

   '<xsl:value-of select="f:pick(f:flip(f:lt(), 5), 8  )" separator="&#xA;"/>'
   '<xsl:value-of select="f:pick(f:flip(f:lt(), 9), 8  )" separator="&#xA;"/>'

 
   
   <xsl:sequence select="f:apply(f:g-le(5), 10)"/>
   
   <xsl:sequence select="f:map( f:pick(f:g-le(5)), 
                                          2 to 10
                               )"
    /> 
 </xsl:template>
</xsl:stylesheet>
