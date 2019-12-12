<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f">

 <xsl:import href="../f/func-iter.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>

 <!-- To be applied on any xml file, or with initial template named "initial"
      
      Expected result: f:iter(4, f:mult(3), 1) = 81
                       The first 2^N greater than 100 =  128
 -->
 
 <xsl:output omit-xml-declaration="yes"/>
    
  <xsl:template name="initial" match="/">
   
    <xsl:sequence select="'f:iter(4, f:mult(3), 1) = ',
                           f:iter(4, f:mult(3), 1)"/>
    <xsl:text>&#xA;</xsl:text>
    
    <xsl:sequence select="'The first 2^N greater than 100 = ', 
        f:iterUntil(f:flip(f:gt(),100), f:mult(2), 1)"/>
  </xsl:template>
</xsl:stylesheet>