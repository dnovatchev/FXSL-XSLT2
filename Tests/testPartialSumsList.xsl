<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:IntegralFunction="IntegralFunction"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 exclude-result-prefixes="f xs IntegralFunction"
>
  <xsl:import href="../f/partialSumsList.xsl"/>

  <!-- To be applied on any source xml.
       Calculates the partial sums for 
       the Integral of x^2 in the interval [0,1] 
       with precision 0.001
    -->
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <IntegralFunction:IntegralFunction/>

  <xsl:template match="/">
    <xsl:variable name="vMyFun" select="document('')/*/IntegralFunction:*[1]"/>

    <xsl:variable name="vrtfPartialSums">
      <xsl:call-template name="partialSumsList">
          <xsl:with-param name="pFun" select="$vMyFun"/>
          <xsl:with-param name="pA" select="0.0E0"/>
          <xsl:with-param name="pB" select="1.0E0"/>
          <xsl:with-param name="pEps" select="0.001E0"/>
      </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vPartialSums" select="$vrtfPartialSums/*"/>
    
    <xsl:copy-of select="$vPartialSums"/>
    

  </xsl:template>
  <xsl:template name="myIntegralFn" match="*[namespace-uri()='IntegralFunction']"
   mode="f:FXSL">
    <xsl:param name="pX" as="xs:double"/>

    <xsl:value-of select="$pX * $pX"/>
  </xsl:template>

</xsl:stylesheet>
