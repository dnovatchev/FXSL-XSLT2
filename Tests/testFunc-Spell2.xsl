<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 <xsl:import href="../f/strSplit-to-Words.xsl"/>
 <xsl:import href="../f/func-spell.xsl"/>
 
 <xsl:variable name="vDict" as="xs:string+"
  select="document('../data/dictEnglish.xml')/*/*"/>
 <xsl:variable name="vcntWords" select="count($vDict)"/>

 <!-- To be applied on ../data/text.xml --> 

 <xsl:template match="/">
    <xsl:call-template name="str-split-to-words">
      <xsl:with-param name="pStr" select="lower-case(/)"/>
      <xsl:with-param name="pDelimiters" 
                      select="',—:.- &#9;&#10;&#13;'"/>
    </xsl:call-template>
  
<!--  
  <xsl:for-each select="1 to 1">
    <xsl:value-of separator="&#xA;"
      select="$vwordNodes[not(f:spell(.))]"/>
  </xsl:for-each>
-->  
 </xsl:template>
</xsl:stylesheet>