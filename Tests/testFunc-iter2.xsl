<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs">

 <xsl:import href="../f/func-iter.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>

 
 <xsl:output omit-xml-declaration="yes"/>
  
    
  <xsl:template match="/">
    <xsl:sequence select="f:scientific2double('4.364976000000000e-002', 10)"/>
  </xsl:template>
  
  <xsl:function name="f:scientific2double" as="xs:double">
    <xsl:param name="x" as="xs:string"/>
    <xsl:param name="b" as="xs:integer"/>

    <xsl:sequence select=
     "for $vTerm1 in xs:double(substring-before($x,'e')),
          $vPow in xs:integer(substring-after($x,'e')),
          $vBase in 
		          if($vPow ge 0)
			         then $b
			         else 1 div $b
			   return
			     f:iter(abs($vPow), f:mult($vBase), $vTerm1)
     "/>
  </xsl:function>
</xsl:stylesheet>