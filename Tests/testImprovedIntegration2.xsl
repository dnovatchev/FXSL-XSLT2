<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:IntegralFunction="IntegralFunction"
xmlns:IntegralFunction2="IntegralFunction2"
xmlns:IntegralFunction3="IntegralFunction3"
xmlns:IntegralFunction4="IntegralFunction4"
 exclude-result-prefixes="f IntegralFunction IntegralFunction2
 IntegralFunction3 IntegralFunction4"
>

  <xsl:import href="../f/improvedIntegration.xsl"/>

  <xsl:output indent="yes" omit-xml-declaration="yes"/>

  <IntegralFunction:IntegralFunction/>
  <IntegralFunction2:IntegralFunction2/>
  <IntegralFunction3:IntegralFunction3/>
  <IntegralFunction4:IntegralFunction4/>

  <xsl:template match="/">
    <xsl:text>&#xA;</xsl:text>
    <xsl:variable name="vMyFun4" select="document('')/*/IntegralFunction4:*[1]"/>
    <xsl:call-template name="improvedIntegration">
      <xsl:with-param name="pFun" select="$vMyFun4"/>
      <xsl:with-param name="pA" select="1E0"/>
      <xsl:with-param name="pB" select="2E0"/>
      <xsl:with-param name="pEpsRough" select="0.001E0"/>
      <xsl:with-param name="pEpsImproved" select="0.01E0"/>
    </xsl:call-template>


  </xsl:template>

  <xsl:template name="myIntegralFn" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction']">
    <xsl:param name="pX"/>

    <xsl:value-of select="$pX * $pX"/>
  </xsl:template>

  <xsl:template name="myIntegralFn2" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction2']">
    <xsl:param name="pX"/>

    <xsl:value-of select="$pX * $pX * $pX"/>
  </xsl:template>

  <xsl:template name="myIntegralFn3" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction3']">
    <xsl:param name="pX"/>

    <xsl:value-of select="4 div (1 + $pX * $pX)"/>
  </xsl:template>

  <xsl:template name="myIntegralFn4" mode="f:FXSL"
   match="*[namespace-uri()='IntegralFunction4']">
    <xsl:param name="pX"/>

    <xsl:value-of select="1 div number($pX)"/>
  </xsl:template>

</xsl:stylesheet>
