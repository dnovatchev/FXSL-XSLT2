<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myFunction="myFunction" 
exclude-result-prefixes="f myFunction"
>
  <xsl:import href="../f/improvedDiffList.xsl"/>

  <myFunction:myFunction/>
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    <xsl:variable name="vMyFun" select="document('')/*/myFunction:*[1]"/>
    
    <xsl:call-template name="improvedDiffList">
	    <xsl:with-param name="pFun" select="$vMyFun"/>
	    <xsl:with-param name="pX" select="15"/>
	    <xsl:with-param name="pH0" select="0.1"/>
	    <xsl:with-param name="pEpsRough" select="0.0001"/>
	    <xsl:with-param name="pEpsImproved" select="0.0000000000001"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="myFunction" match="*[namespace-uri()='myFunction']"
   mode="f:FXSL">
     <xsl:param name="pParam" select="/.."/>
     
     <xsl:value-of select="$pParam * $pParam"/>
  </xsl:template>

</xsl:stylesheet>
