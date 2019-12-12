<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myFunction="f:myFunction" 
exclude-result-prefixes="f myFunction"
>
  <xsl:import href="../f/improvedDiff.xsl"/>
  
  <!-- To be applied on any source xml -->

  <myFunction:myFunction/>
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    <xsl:variable name="vMyFun" select="document('')/*/myFunction:*[1]"/>
    f  = x^2
    x  = 15
    h0 = 0.1
    EpsRough    =  0.0001
    EpsImproved =  0.000000000001
    f'(x)       = <xsl:text/>    
    <xsl:call-template name="improvedDiff">
	    <xsl:with-param name="pFun" select="$vMyFun"/>
	    <xsl:with-param name="pX" select="15"/>
	    <xsl:with-param name="pH0" select="0.1"/>
	    <xsl:with-param name="pEpsRough" select="0.0001"/>
	    <xsl:with-param name="pEpsImproved" select="0.000000000001"/>
    </xsl:call-template>
    
    f  = x^2
    x  = 0.5
    h0 = 0.1
    EpsRough    =  0.0001
    EpsImproved =  0.0000000000001
    f'(x)       = <xsl:text/>    
    <xsl:call-template name="improvedDiff">
	    <xsl:with-param name="pFun" select="$vMyFun"/>
	    <xsl:with-param name="pX" select="0.5"/>
	    <xsl:with-param name="pH0" select="0.1"/>
	    <xsl:with-param name="pEpsRough" select="0.0001"/>
	    <xsl:with-param name="pEpsImproved" select="0.0000000000001"/>
    </xsl:call-template>
    
    f  = x^2
    x  = 6
    h0 = 0.1
    EpsRough    =  0.0001
    EpsImproved =  0.0000000000001
    f'(x)       = <xsl:text/>    
    <xsl:call-template name="improvedDiff">
	    <xsl:with-param name="pFun" select="$vMyFun"/>
	    <xsl:with-param name="pX" select="6"/>
	    <xsl:with-param name="pH0" select="0.1"/>
	    <xsl:with-param name="pEpsRough" select="0.0001"/>
	    <xsl:with-param name="pEpsImproved" select="0.0000000000001"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="myFunction" match="*[namespace-uri()='f:myFunction']"
   mode="f:FXSL">
     <xsl:param name="pParam" select="/.."/>
     
     <xsl:value-of select="number($pParam) * number($pParam)"/>
  </xsl:template>

</xsl:stylesheet>
