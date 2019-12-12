<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f"
>
   <xsl:import href="../f/func-product.xsl"/>

    <xsl:output  encoding="UTF-8" omit-xml-declaration="yes"/>

   <!-- This transformation should be applied to:
        testProduct.xml 
     -->

    <xsl:template match="/">
      <xsl:value-of select=
      "f:product(/*/*/*/*/(*[@sqlsource='newshares'] 
                         div 
                           *[@sqlsource='oldshares']))"/>
    </xsl:template>
</xsl:stylesheet>