<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
  <xsl:import href="../f/improve.xsl"/> 

  <!-- To be applied on diff-results.xml -->

  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
  
      <xsl:variable name="vrtfI1">
	    <xsl:call-template name="improve">
	      <xsl:with-param name="pList" select="/*/*[position() > 1]"/>
	    </xsl:call-template>
    </xsl:variable>
    Improve 1:
    <xsl:copy-of select="$vrtfI1/*"/>
    <xsl:variable name="vrtfI2">
	    <xsl:call-template name="improve">
	      <xsl:with-param name="pList" select="$vrtfI1/*"/>
	    </xsl:call-template>
    </xsl:variable>
    Improve 2:
    <xsl:copy-of select="$vrtfI2/*"/>

    <xsl:variable name="vrtfI3">
	    <xsl:call-template name="improve">
	      <xsl:with-param name="pList" select="$vrtfI2/*"/>
	    </xsl:call-template>
    </xsl:variable>
    Improve 3:
    <xsl:copy-of select="$vrtfI3/*"/>

    <xsl:variable name="vrtfI4">
	    <xsl:call-template name="improve">
	      <xsl:with-param name="pList" select="$vrtfI3/*"/>
	    </xsl:call-template>
    </xsl:variable>
    Improve 4:
    <xsl:copy-of select="$vrtfI4/*"/>

  </xsl:template>

</xsl:stylesheet>
