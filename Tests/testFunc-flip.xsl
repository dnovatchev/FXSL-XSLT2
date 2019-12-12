<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:flip="http://fxsl.sf.net/flip/"
 exclude-result-prefixes="f flip"
>
   <xsl:import href="../f/func-exp.xsl"/>
   <xsl:import href="../f/func-flip.xsl"/>
   <xsl:import href="../f/func-map.xsl"/>
   
   <xsl:output method="text"/>

  <xsl:template match="/">
f:pow(2,5) = <xsl:value-of select="f:pow(2,5)"/>
-----------------------------------------------
f:flip(f:pow(), 2, 5) = <xsl:value-of select="f:flip(f:pow(), 2, 5)"/>
-----------------------------------------------
f:map(f:flip(f:pow(),2), 1 to 10) = <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:map(f:flip(f:pow(),2), 1 to 10)" separator="&#xA;"/>
-----------------------------------------------
f:map(f:flip(f:pow(),10), 1 to 10) = <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:map(f:flip(f:pow(),10), 1 to 10)" separator="&#xA;"/>
-----------------------------------------------
sum(f:map(f:flip(f:pow(),10), 1 to 10)) = <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="sum(f:map(f:flip(f:pow(),10), 1 to 10))" separator="&#xA;"/>
-----------------------------------------------
f:pow(sum(f:map(f:flip(f:pow(),10), 1 to 10)), 0.1) = <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:pow(sum(f:map(f:flip(f:pow(),10), 1 to 10)), 0.1)" separator="&#xA;"/>
-----------------------------------------------
f:log(2,4) = <xsl:value-of select="f:log(2,4)"/>
-----------------------------------------------
f:flip(f:log(), 2, 4) = <xsl:value-of select="f:flip(f:log(), 2, 4)"/>
-----------------------------------------------
f:map(f:flip(f:log(),2), 2 to 10) = <xsl:text>&#xA;</xsl:text>
    <xsl:value-of select="f:map(f:flip(f:log(),2), 2 to 10)" separator="&#xA;"/>

  </xsl:template>
</xsl:stylesheet>