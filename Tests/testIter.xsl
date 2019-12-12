<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:myMultiplyby3="f:myMultiplyby3" 
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f myMultiplyby3">

 <xsl:import href="../f/iter.xsl"/>
 
 <xsl:output omit-xml-declaration="yes"/>
  
  <myMultiplyby3:myMultiplyby3/>
  
  <xsl:template match="/">
  
   <xsl:variable name="vMultBy3" select="document('')/*/myMultiplyby3:*[1]"/>
   
    <xsl:call-template name="iter">
      <xsl:with-param name="pTimes" select="4"/>
      <xsl:with-param name="pFun" select="$vMultBy3"/>
      <xsl:with-param name="pX" select="1"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="myMultiplyby3:*" mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:value-of select="3 * $arg1"/>
  </xsl:template>
    
</xsl:stylesheet>
