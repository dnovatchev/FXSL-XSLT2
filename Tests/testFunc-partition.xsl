<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:myIsEven="myIsEven"
>
 
  <xsl:import href="../f/func-partition.xsl"/>
  
  <!-- To be applied on ../data/numList.xml

       Expected result: 
 -->
 
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <myIsEven:myIsEven/>
  
  <xsl:template match="/">
    <xsl:variable name="vIsEven" select="document('')/*/myIsEven:*[1]"/>
    
    Partitioning by IsEven:

    <xsl:value-of select="f:partition(/*/*, $vIsEven)" 
                  separator=", "/>

    Partitioning by IsEven:
    <xsl:value-of select="f:partition(1 to 10, $vIsEven)" 
                  separator=", "/>

  </xsl:template>
  
  <xsl:template name="myIsEven" match="*[namespace-uri()='myIsEven']"
   mode="f:FXSL">
    <xsl:param name="arg1"/>
    
    <xsl:sequence select="$arg1 mod 2 = 0"/>
  </xsl:template>
</xsl:stylesheet>
