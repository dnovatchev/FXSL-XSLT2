<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f" 
 >
 
 <xsl:import href="../f/func-map.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>
 <xsl:import href="../f/func-trignm.xsl"/>
 <!-- To be applied on any xml file -->

 <xsl:output method="text"/>
  
  <xsl:template match="/">
	 <xsl:value-of select="f:cos(240, .00000001, 'deg')"/>
   <xsl:text>&#xA;</xsl:text>
   <xsl:for-each select="(1 to 10)">
      <xsl:variable name="x" select="xs:double(.)"/>
     <xsl:copy-of select="('sin^2(', ., ') + cos^2(', ., ') = ', f:cos($x)*f:cos($x) + f:sin($x)*f:sin($x), '&#xA;')"/>
   </xsl:for-each>
   
   <xsl:for-each select="(1 to 10)">
      <xsl:variable name="x" select="xs:double(.)"/>
     <xsl:copy-of select="('sin^2(', ., ') + cos^2(', ., ') = ', 
                          f:cos($x, 0.01)*f:cos($x, 0.01) 
                          + f:sin($x, 0.01)*f:sin($x, 0.01), 
                          '&#xA;')"/>
   </xsl:for-each>
   
   <xsl:for-each select="(1 to 10)">
      <xsl:variable name="x" select="xs:double(.)"/>
     <xsl:copy-of select="('tan(', ., ') * cot(', ., ') = ', f:tan($x)*f:cot($x), '&#xA;')"/>
   </xsl:for-each>

  -----------------------------------------
  f:map(f:sin(), 1 to 10) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:sin(), 1 to 10)" separator="&#xA;"/>
  -----------------------------------------
  f:map(f:cos(), 1 to 10) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:cos(), 1 to 10)" separator="&#xA;"/>
  -----------------------------------------
  f:map(f:tan(), 1 to 10) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:tan(), 1 to 10)" separator="&#xA;"/>
  -----------------------------------------
  f:map(f:cot(), 1 to 10) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:cot(), 1 to 10)" separator="&#xA;"/>
  -----------------------------------------
  f:map(f:sec(), 1 to 10) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:sec(), 1 to 10)" separator="&#xA;"/>
  -----------------------------------------
  f:map(f:csc(), 1 to 10) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:csc(), 1 to 10)" separator="&#xA;"/>
  -----------------------------------------
  f:map(f:degrees(), f:map(f:mult(3.14159263597), 1 to 10)) = &#xA;<xsl:text/>
  <xsl:value-of select=
  "f:map(f:degrees(), f:map(f:mult(3.14159263597), 1 to 10))" separator="&#xA;"/>
  -----------------------------------------

  f:map(f:radians(), f:map(f:mult(180), 1 to 10)) = &#xA;<xsl:text/>
  <xsl:value-of select="f:map(f:radians(), f:map(f:mult(180), 1 to 10))" separator="&#xA;"/>
 </xsl:template>
</xsl:stylesheet>