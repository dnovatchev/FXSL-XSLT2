<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
 >
  
  <xsl:import href="../f/randomList.xsl"/>
  
  <!-- Can be applied on any source xml document (ignored) -->
  <xsl:output omit-xml-declaration="yes" indent="yes"/>
  
  <xsl:template match="/">
    <list>
	    <xsl:call-template name="randomizeList">
	      <xsl:with-param name="pList" select="1  to 200"/>
	    </xsl:call-template>
    </list>
  </xsl:template>
</xsl:stylesheet>