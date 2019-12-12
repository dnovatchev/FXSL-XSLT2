<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-flip.xsl"/>
 <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
 <xsl:import href="../f/func-transform-and-sum.xsl"/>

<!--
  To be applied on testFunc-func-and-operators3.xml
-->

 <xsl:output method="text"/>
 
 <xsl:template match="/*">
   <xsl:value-of select=
   "f:transform-and-sum(f:flip(f:substring-before(), '*'), 
                        data(/*/*/@colwidth))"
   />   
 </xsl:template>
</xsl:stylesheet>