<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
  <xsl:import href="../f/func-maxDepth.xsl"/>

<!--   To be applied on: ../data/breadthFirst.xml 

       Expected result: Maximum depth of the input xml document is: 5
-->
  
  <xsl:template match="/">
   Maximum depth of the input xml document is: <xsl:text/>
   <xsl:value-of select="f:maxDepth(/)"/>
  </xsl:template>
</xsl:stylesheet>