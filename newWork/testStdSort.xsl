<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="xs f"
>

 <xsl:import href="../f/func-trignm.xsl"/>
 
 <xsl:output method="text"/>
 
 <xsl:template match="/">
   <xsl:variable name="vSeq" as="xs:double*"
   select="for $i in 1 to 10000 return f:sin($i)"/>
   
   <xsl:for-each select="$vSeq">
     <xsl:sort/>
     <xsl:value-of select="."/><xsl:text>&#xA;</xsl:text>
   </xsl:for-each>
 </xsl:template>
 
</xsl:stylesheet>
