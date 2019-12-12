<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
   <xsl:import href="../f/func-sum.xsl"/>

   <!-- This transformation must be applied to:
        numList.xml 
     -->
    <xsl:output omit-xml-declaration="yes"/>

    <xsl:template match="/">
      <xsl:value-of select="f:sum( ((/*/*), 1 to 10) )"/>
    </xsl:template>
</xsl:stylesheet>
