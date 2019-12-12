<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-Operators.xsl"/>
 <xsl:import href="../f/func-standardXpathFunctions.xsl"/>
 <xsl:import href="../f/func-map.xsl"/>
 <xsl:import href="../f/func-flip.xsl"/>
 <xsl:import href="../f/func-zipWithDVC.xsl"/>
 <xsl:import href="../f/func-exp.xsl"/>
 <xsl:import href="../f/func-sqrt.xsl"/>

<!--
  To be applied on testFunc-xsltSort.xml
                                        
      Expected result: 2                
-->

 <xsl:output method="text"/>
 
 <xsl:template name="initial" match="/">
   <xsl:sequence select=
     "2*f:xsltSort(/*/*/@sortorder/xs:integer(.), f:add(0))[1]"/>   
 </xsl:template>
</xsl:stylesheet>