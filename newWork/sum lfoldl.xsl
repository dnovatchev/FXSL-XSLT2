<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="../f/func-foldl.xsl"/>
 <xsl:import href="../f/func-Operators.xsl"/>
  
 <xsl:template match="/">
   <xsl:sequence select="f:foldl(f:add(), 0, 1 to 1000000)"/>
 </xsl:template>
</xsl:stylesheet>