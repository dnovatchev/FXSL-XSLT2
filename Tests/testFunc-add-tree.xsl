<xsl:stylesheet version="2.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
xmlns:add-tree="add-tree" 
exclude-result-prefixes="f add-tree"
>
    <xsl:import href="../f/func-addTree.xsl"/>

   <!-- This transformation must be applied to:
        ../data/numTree.xml 

        Expected result is 66
    -->

    <xsl:output method="text"/>
    
    <xsl:template match="/">
      <xsl:value-of select="f:add-tree(/*)"/>
    </xsl:template>
</xsl:stylesheet>
