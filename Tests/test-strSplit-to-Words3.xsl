<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
>

   <xsl:import href="../f/strSplit-to-Words.xsl"/>
<!-- This transformation must be applied to:
        testSplitToWords4.xml               
-->

   <xsl:output indent="yes" omit-xml-declaration="yes"/>
   
   <xsl:template match="/">
     <xsl:for-each select=
      "for $v in /*/*[@type='individual'] return 
         f:lastWord($v)">
       <xsl:sort select="substring(.,1,1)"/>
        
        <xsl:value-of select="concat(., '&#xA;')"/>     
      </xsl:for-each>
   </xsl:template>
   
    <xsl:function name="f:lastWord" as="xs:string*">
      <xsl:param name="vTexts" as="xs:string*"/>
      
      <xsl:variable name="vwordNodes" as="node()*">
        <xsl:call-template name="str-split-to-words">
          <xsl:with-param name="pStr" select="$vTexts"/>
          <xsl:with-param name="pDelimiters" 
                          select="' .&#10;&#13;'"/>
        </xsl:call-template>
      </xsl:variable>
      
      <xsl:sequence select="$vwordNodes[last()]/text()"/>
    </xsl:function>
</xsl:stylesheet>
