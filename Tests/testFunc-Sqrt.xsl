<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"

>
  <xsl:import href="../f/func-sqrt.xsl"/>
  
  <!-- To be applied on any source xml. 
       This also tests the within() function 
  -->
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/*" name="initial">
     sqrt(0.25): <xsl:value-of select="f:sqrt(0.25, 0.00001)"/>
     sqrt(1): <xsl:value-of select="f:sqrt(1, 0.00001)"/>
     sqrt(2): <xsl:value-of select="f:sqrt(2, 0.00001)"/>
     sqrt(4): <xsl:value-of select="f:sqrt(4, 0.00001)"/>
     sqrt(9): <xsl:value-of select="f:sqrt(9, 0.00001)"/>
     sqrt(13): <xsl:value-of select="f:sqrt(13, 0.00001)"/>
     sqrt(16): <xsl:value-of select="f:sqrt(16, 0.00001)"/>
     sqrt(25): <xsl:value-of select="f:sqrt(25, 0.00001)"/>
     sqrt(36): <xsl:value-of select="f:sqrt(36, 0.00001)"/>
     sqrt(49): <xsl:value-of select="f:sqrt(49, 0.00001)"/>
     sqrt(64): <xsl:value-of select="f:sqrt(64, 0.00001)"/>
     sqrt(81): <xsl:value-of select="f:sqrt(81, 0.00001)"/>
     sqrt(100): <xsl:value-of select="f:sqrt(100, 0.00001)"/>
     sqrt(121): <xsl:value-of select="f:sqrt(121, 0.00001)"/>
  </xsl:template>

</xsl:stylesheet>
