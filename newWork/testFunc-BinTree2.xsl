<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="Func-BinTree.xsl"/>
 
 <xsl:template match="/">

<!--  Some initial memory -->
    <xsl:variable name="vMem"
     select="f:memNew(1 to 10)"/>
     
    <xsl:variable name="vallNodes" as="xs:integer*"
      select="/*/*/xs:integer(.)"/>
    
    <xsl:variable name="vMem1" select="f:memAdd($vMem,$vallNodes[1])"/> 
    
    <xsl:variable name="vstartTree" select=
         "f:makeBTree($vMem1[1], $vMem1)"/>
    
    <xsl:variable name="vFinalTree" select=
     "f:btAddSeq(subsequence($vallNodes,2), $vstartTree[1], $vstartTree)"
     />
     
===================

  <xsl:sequence select="f:printTree($vFinalTree[1], $vFinalTree)"/>     

 </xsl:template>

</xsl:stylesheet>