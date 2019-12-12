<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
 >
  <xsl:import href="../f/func-Operators.xsl"/>
  <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
  <xsl:import href="../f/func-exp.xsl"/>
  <xsl:import href="../f/func-flip.xsl"/>
  <xsl:import href="../f/func-map.xsl"/>
  
  <xsl:output omit-xml-declaration="yes"/>
  
  <!-- To be performed on: testMin.xml -->

  <xsl:template match="/">
    <xsl:sequence select=
     "data(/*/*/@*
            [string-length(.) 
            = 
             min(f:map(f:string-length(),/*/*/@*))]
           )"
     />
  </xsl:template>
</xsl:stylesheet>