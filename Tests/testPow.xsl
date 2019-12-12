<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
 
  <xsl:import href="../f/pow.xsl"/> 

  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:for-each select="(document('')//node())[position() &lt; 10]">
	    <xsl:value-of select="concat(string(position()), '^', string(position()),' = ')"/>
	    <xsl:call-template name="pow">
	      <xsl:with-param name="pTimes" select="position()"/>
	      <xsl:with-param name="pX" select="number(position())"/>
	    </xsl:call-template>
	    <xsl:text>&#xA;</xsl:text>
    </xsl:for-each>

(1 + 1/5000)^5000 = <xsl:text/>
	    <xsl:call-template name="pow">
	      <xsl:with-param name="pTimes" select="5000"/>
	      <xsl:with-param name="pX" select="1.0002E0"/>
	    </xsl:call-template>
      <xsl:message>The End</xsl:message>
  </xsl:template>

</xsl:stylesheet>
