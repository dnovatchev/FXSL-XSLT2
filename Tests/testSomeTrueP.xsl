<xsl:stylesheet version="2.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 xmlns:myPred="f:myPred"
 exclude-result-prefixes="f myPred"
 >
  <xsl:import href="../f/someTrueP.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>
  
   <!-- This transformation must be applied to:
        numList.xml 
     -->
     
  <myPred:myPred/>
  
  <xsl:variable name="vFunP" select="document('')/*/myPred:*[1]"/>

  <xsl:template match="/">
	    <xsl:call-template name="someTrueP">
	      <xsl:with-param name="pList" select="/*/*"/>
        <xsl:with-param name="pPredicate" select="$vFunP"/>
	    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="myPred:*" mode="f:FXSL">
    <xsl:param name="arg1" select="/.."/>
      <xsl:if test="$arg1 > 8">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>
