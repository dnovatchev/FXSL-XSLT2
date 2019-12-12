<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myPredicate="myPredicate"
exclude-result-prefixes="f myPredicate"
>
  <xsl:import href="../f/allTrue.xsl"/>
  <xsl:import href="../f/someTrue.xsl"/>
  <xsl:import href="../f/someTrueP.xsl"/>
  <xsl:import href="../f/allTrueP.xsl"/>

   <!-- This transformation must be applied to:
        boolNodes.xml 
     -->

  <myPredicate:myPredicate/>
  <xsl:variable name="vPredicate" select="document('')/*/myPredicate:*[1]" />
    
  <xsl:output omit-xml-declaration="yes"/>
  
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
    
    <xsl:text>&#xA;</xsl:text>
   
    <xsl:variable name="someTrueP">
	    <xsl:call-template name="someTrueP">
	      <xsl:with-param name="pList" select="/*/*"/>
	      <xsl:with-param name="pPredicate" select="$vPredicate"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
	    <xsl:when test="not(string($someTrueP))">
	      <xsl:text>None hold true for: </xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>Some are true for:</xsl:text>
	    </xsl:otherwise>
    </xsl:choose>
    
    <xsl:text>(= 'x') in: </xsl:text>
    
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
     <xsl:text>&#xA;</xsl:text>
   
    <xsl:variable name="allTrueP">
	    <xsl:call-template name="allTrueP">
	      <xsl:with-param name="pList" select="/*/*"/>
	      <xsl:with-param name="pPredicate" select="$vPredicate"/>
	    </xsl:call-template>
    </xsl:variable>
    
    <xsl:choose>
	    <xsl:when test="not(string($allTrueP))">
	      <xsl:text>Not all hold true for: </xsl:text>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:text>All hold true for:</xsl:text>
	    </xsl:otherwise>
    </xsl:choose>
    
    <xsl:text>(= 'x') in: </xsl:text>
    
    <xsl:text>&#xA;</xsl:text>
    <xsl:copy-of select="/*/*"/>
  
  </xsl:template>
  
  <xsl:template name="myPredicate" mode="f:FXSL"
   match="*[namespace-uri()='myPredicate']">
    <xsl:param name="arg1"/>
    
    <xsl:if test="$arg1 = 'x'">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>
