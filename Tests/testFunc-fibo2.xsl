<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:saxon="http://saxon.sf.net/"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs saxon f" 
 >
  <xsl:import href="../f/func-Fibonacci.xsl"/>

 <xsl:output method="text"/>
 
  <xsl:template name="initial" match="/">
   The Fibonacci's number F3000:
<xsl:text/>
   <xsl:value-of select="f:fibo2(3000)"/>
  </xsl:template>

</xsl:stylesheet>