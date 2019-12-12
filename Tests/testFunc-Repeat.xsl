<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/func-repeat.xsl"/>
 <xsl:import href="../f/func-zipWithDVC.xsl"/>
 <xsl:import href="../f/func-append.xsl"/>
 
 <xsl:output method="text" />
  
  <xsl:variable name="test" select="'test'"/>
  <xsl:template match="/">
    <xsl:value-of separator="" select=
    "f:zipWith(f:append(), f:repeat(' Hi... ', 10), f:repeat('&#xA;', 10))"/>
    
    <xsl:value-of select="f:string-pad('Hi..', '1234567890', 25)"/>
  </xsl:template>
  
  <xsl:function name="f:string-pad" as="xs:string">
    <xsl:param name="pStr" as="xs:string"/>
    <xsl:param name="pPadStr" as="xs:string"/>
    <xsl:param name="pTotalLength" as="xs:integer"/>
    
    <xsl:sequence select=
    "for $len in string-length($pStr),
         $padLen in string-length($pPadStr),
         $padTimes in ($pTotalLength - $len) idiv $padLen
       return
         string-join(
                     ($pStr,
                      f:repeat($pPadStr, $padTimes),
                      substring($pPadStr, 1, ($pTotalLength - $len) mod $padLen)
                       ),
                       ''
                       )
         "
    />
  </xsl:function>
</xsl:stylesheet>