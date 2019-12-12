<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-Operators.xsl"/>
 <xsl:import href="../f/func-exp.xsl"/>
 <xsl:import href="../f/func-map.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>
 <xsl:import href="../f/func-zipWithDVC.xsl"/>


 <!-- To be applied on any xml file, or with initial template named "initial"
      
      Expected result: see ../testResults/testFunc-operators.out
 -->

 <xsl:output omit-xml-declaration="yes"/>
 
 <xsl:template name="initial" match="/">
   f:add(f:add(2,3), 7) = <xsl:value-of select="f:add(f:add(2,3), 7)"/>
   ======================================
   f:map( f:add(100), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:add(100), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:flip(f:add(), 100), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:flip(f:add(), 100), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:subtr(100), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:subtr(100), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:flip(f:subtr(), 100), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:flip(f:subtr(), 100), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:mult(3), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:mult(3), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:flip(f:mult(), 3), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:flip(f:mult(), 3), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:div(5), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:div(5), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:flip(f:div(), 5), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:flip(f:div(), 5), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:idiv(6), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:idiv(6), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:flip(f:idiv(), 6), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:flip(f:idiv(), 6), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:mod(10), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:mod(10), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map( f:flip(f:mod(), 3), 1 to 10 ) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map( f:flip(f:mod(), 3), 1 to 10 )" separator="&#xA;"/>
   
   ======================================
   f:map(f:pow(2),  0 to 9) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:map(f:pow(2),  0 to 9)" 
   separator="&#xA;"/>
   
   ======================================
<!----> 
   f:zipWith(f:g-eq(), 1 to 10, f:map(f:pow(2),  0 to 9)) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:zipWith(f:g-eq(), 1 to 10, f:map(f:pow(2),  0 to 9))" 
   separator="&#xA;"/>
   
   ======================================
   f:zipWith(f:g-ne(), 1 to 10, f:map(f:pow(2),  0 to 9)) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:zipWith(f:g-ne(), 1 to 10, f:map(f:pow(2),  0 to 9))" 
   separator="&#xA;"/>
  
   ======================================
   f:zipWith(f:lt(), 1 to 10, 1 to 10) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:zipWith(f:lt(), 1 to 10, 1 to 10)" 
   separator="&#xA;"/>
   
   ======================================
   f:zipWith(f:le(), 1 to 10, 1 to 10) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:zipWith(f:le(), 1 to 10, 1 to 10)" 
   separator="&#xA;"/>
   
   ======================================
   f:zipWith(f:gt(), 1 to 10, 1 to 10) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:zipWith(f:gt(), 1 to 10, 1 to 10)" 
   separator="&#xA;"/>
   
   ======================================
   f:zipWith(f:ge(), 1 to 10, 1 to 10) =<xsl:text>&#xA;</xsl:text>
   <xsl:value-of select="f:zipWith(f:ge(), 1 to 10, 1 to 10)" 
   separator="&#xA;"/>
   
 </xsl:template>
</xsl:stylesheet>
