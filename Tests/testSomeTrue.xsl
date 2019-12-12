<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
 >
  <xsl:import href="../f/allTrue.xsl"/>
  <xsl:import href="../f/someTrue.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>
  
   <!-- This transformation must be applied to:
        boolNodes.xml 
     -->

  <xsl:template match="/">
    <xsl:variable name="allTrue">
	    <xsl:call-template name="allTrue">
	      <xsl:with-param name="pList" select="/*/*"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:if test="not(string($allTrue))">
      <xsl:text>Not </xsl:text>
    </xsl:if>
    <xsl:value-of select="'all nodes contents are true in:'"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
 
    <xsl:text>&#xA;</xsl:text>
       
    <xsl:variable name="someTrue">
	    <xsl:call-template name="someTrue">
	      <xsl:with-param name="pList" select="/*/*"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
	    <xsl:when test="not(string($someTrue))">
	      <xsl:text>None are true</xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>Some are true</xsl:text>
	    </xsl:otherwise>
    </xsl:choose>
    
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
     
  </xsl:template>
</xsl:stylesheet>
