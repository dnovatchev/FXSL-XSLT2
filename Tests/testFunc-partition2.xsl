<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
>
 
  <xsl:import href="../f/func-partition.xsl"/>
  <xsl:import href="../f/func-flip.xsl"/>
  <xsl:import href="../f/func-Operators.xsl"/>
  
  <!-- To be applied on ../data/numList.xml -->
 
  <xsl:output indent="yes" omit-xml-declaration="yes"/>
  
  <xsl:template match="/">
    Partitioning by IsEven:

    <xsl:value-of select="f:partition(/*/*, f:flip(f:mod(),2) )"
                  separator=", "/>

    Partitioning by IsEven:
    <xsl:value-of select="f:partition(1 to 10, f:flip(f:mod(),2) )" 
                  separator=", "/>
  </xsl:template>
</xsl:stylesheet>
