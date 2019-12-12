<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myIsEven="myIsEven"
exclude-result-prefixes="f myIsEven"
>
 
  <xsl:import href="../f/func-filter.xsl"/>
  
  <!-- To be applied on ../data/numList.xml 

       Expected result:
               Filtering by IsEven:
	       02, 04, 06, 08, 10,

-->
 
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <myIsEven:myIsEven/>
  
  <xsl:template match="/">
    <xsl:variable name="vIsEven" select="document('')/*/myIsEven:*[1]"/>
    
    Filtering by IsEven:
    <xsl:for-each select="f:filter(/*/*/text(), $vIsEven)">
      <xsl:value-of select="concat(., ', ')"/>
    </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="myIsEven" match="*[namespace-uri()='myIsEven']"
   mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:if test="$arg1 mod 2 = 0">1</xsl:if>
  </xsl:template>
</xsl:stylesheet>