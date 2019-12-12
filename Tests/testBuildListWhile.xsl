<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:pGenerator="pGenerator"
xmlns:pController="pController" 
xmlns:pTakeController="pTakeController" 
xmlns:pTakeController2="pTakeController2" 
xmlns:pTakeController3="pTakeController3" 
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f pGenerator pController 
  pTakeController pTakeController2 pTakeController3" 
>
  <!-- <xsl:import href="buildListWhile.xsl"/> -->
  <xsl:import href="../f/takeWhile.xsl"/> 
  <xsl:import href="../f/take.xsl"/> 

   <!-- This transformation must be applied to:
        numList.xml 
    -->
   
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <pGenerator:pGenerator/>
  <pController:pController/>
  <pTakeController:pTakeController/>
  <pTakeController2:pTakeController2/>
  <pTakeController3:pTakeController3/>
  
  <xsl:variable name="vMyGenerator" select="document('')/*/pGenerator:*[1]"/>
  <xsl:variable name="vMyController" select="document('')/*/pController:*[1]"/>
  <xsl:variable name="vMyTakeController" select="document('')/*/pTakeController:*[1]"/>
  <xsl:variable name="vMyTakeController2" select="document('')/*/pTakeController2:*[1]"/>
  <xsl:variable name="vMyTakeController3" select="document('')/*/pTakeController3:*[1]"/>
  
  <xsl:template match="/">
    buildListWhile Generator: 2 * N, Controller: count &lt;= 10
    <xsl:variable name="v1-10">
	  <xsl:call-template name="buildListWhile">
		    <xsl:with-param name="pGenerator" select="$vMyGenerator"/>
		    <xsl:with-param name="pController" select="$vMyController"/>
	  </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="vList-1-10" select="$v1-10/*"/>
    
    <xsl:copy-of select="$vList-1-10"/>
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    
    takeWhile $vList-1-10, Controller: &lt; 15 
    <xsl:call-template name="takeWhile">
	  <xsl:with-param name="pList" select="$vList-1-10" />
	  <xsl:with-param name="pController" select="$vMyTakeController2"/>
    </xsl:call-template>
    
    <xsl:text>&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    takeWhile Generator: 2 * N, Controller: &lt; 7 
    <xsl:call-template name="takeWhile">
      <xsl:with-param name="pGenerator" select="$vMyGenerator"/>
	  <xsl:with-param name="pController" select="$vMyTakeController"/>
    </xsl:call-template>

    <xsl:text>&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    takeWhile Generator: 2 * N, Controller: count &lt;= 5 
    <xsl:call-template name="takeWhile">
      <xsl:with-param name="pGenerator" select="$vMyGenerator"/>
	  <xsl:with-param name="pController" select="$vMyTakeController3"/>
    </xsl:call-template>

    <xsl:text>&#xA;</xsl:text>
    <xsl:text>&#xA;</xsl:text>
    takeWhile Generator: 2 * N, N=8 
    <xsl:call-template name="take">
      <xsl:with-param name="pGenerator" select="$vMyGenerator"/>
	  <xsl:with-param name="pN" select="8"/>
    </xsl:call-template>

  </xsl:template>

  <xsl:template name="listGenerator" mode="f:FXSL"
       match="*[namespace-uri()='pGenerator']">
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams"/>
     
     <xsl:value-of select="(count($pList) + 1) * 2"/>
  </xsl:template>
  
  <xsl:template name="listController" mode="f:FXSL"
      match="*[namespace-uri()='pController']">
     <xsl:param name="pList" select="/.."/>
     <xsl:param name="pParams"/>
     
     <xsl:if test="count($pList) &lt;= 10">1</xsl:if>
  </xsl:template>
  
  <xsl:template name="takeController" mode="f:FXSL"
       match="*[namespace-uri()='pTakeController']">
     <xsl:param name="pList"/>
     <xsl:param name="pParams"/>
     
     <xsl:if test="$pList[last()] &lt;= 7">1</xsl:if>
  </xsl:template>

  <xsl:template name="takeController2" mode="f:FXSL"
       match="*[namespace-uri()='pTakeController2']">
     <xsl:param name="pList"/>
     <xsl:param name="pParams"/>
     
     <xsl:if test="$pList[last()] &lt;= 15">1</xsl:if>
  </xsl:template>
    
  <xsl:template name="takeController3" mode="f:FXSL"
       match="*[namespace-uri()='pTakeController3']">
     <xsl:param name="pList"/>
     <xsl:param name="pParams"/>
     
     <xsl:if test="count($pList) &lt;= 5">1</xsl:if>
  </xsl:template>
    
</xsl:stylesheet>