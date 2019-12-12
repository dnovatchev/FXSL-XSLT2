<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:mySpanController="mySpanController"
exclude-result-prefixes="f mySpanController"
>
  <xsl:import href="../f/split.xsl"/>
  <xsl:import href="../f/span.xsl"/>
  
  <!-- To be applied on numList.xml -->
  
  <mySpanController:mySpanController/>
  
  <xsl:variable name="vSpanController" select="document('')/*/mySpanController:*[1]"/>
  
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    Split 4
    <xsl:call-template name="split">
      <xsl:with-param name="pList" select="/*/*"/>
      <xsl:with-param name="pN" select="4"/>
    </xsl:call-template>
    
    Span &lt;= 3:
    <xsl:call-template name="span">
      <xsl:with-param name="pList" select="/*/*"/>
      <xsl:with-param name="pController" select="$vSpanController"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="mySpanController" mode="f:FXSL"
   match="*[namespace-uri()='mySpanController']">
     <xsl:param name="pList" select="/.."/>
     
     <xsl:if test="$pList &lt;= 3">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>
