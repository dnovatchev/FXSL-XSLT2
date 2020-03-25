<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="func-MemoryId.xsl"/>
 <xsl:import href="../f/func-foldl.xsl"/>
 
 <xsl:template match="/">
    <xsl:variable name="vMem"
     select="f:memNew(1 to 10000)"/>
    <xsl:sequence select="$vMem"/>
    

    <xsl:for-each select="1 to 100">
	    <xsl:for-each select="1 to 10">
		    ===============
		    <xsl:variable name="vStart" select="(current()-1)*1000 + 901"/>
		    <xsl:variable name="vEnd" select="$vStart + 9"/>
		    
		    <xsl:sequence select="f:memGetSeq($vMem, $vStart,$vEnd)"/>
	    </xsl:for-each>
    </xsl:for-each>
    
 </xsl:template>

</xsl:stylesheet>