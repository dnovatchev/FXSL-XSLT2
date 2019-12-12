<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:f="http://fxsl.sf.net/"
  exclude-result-prefixes="f" 
 >
 
 <xsl:import href="../f/func-progressions.xsl"/>
 <!-- To be applied on any xml file, or with initial template named "initial" -->
 
 <xsl:output omit-xml-declaration="yes" indent="yes"/>
 
  <xsl:template name="initial" match="/">
    <xsl:value-of select="f:arithmetic-progression(7E0,2.8E0, -0.5E0)" 
                  separator=", "/>
  </xsl:template>

</xsl:stylesheet>
