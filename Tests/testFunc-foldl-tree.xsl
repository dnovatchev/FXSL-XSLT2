<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>
    <xsl:import href="../f/func-foldl-tree.xsl"/>
    <xsl:import href="../f/func-Operators.xsl"/>

   <!-- This transformation must be applied to:
        ../data/numTree.xml 

        Expected result: 66
    -->
    <xsl:output method="text"/>
    
    <xsl:template match="/">
      <xsl:value-of select="f:foldl-tree(f:add(), f:add(), 0, /*)"/>
    </xsl:template>
</xsl:stylesheet>
