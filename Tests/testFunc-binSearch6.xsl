<xsl:stylesheet version="2.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:f="http://fxsl.sf.net/"
 exclude-result-prefixes="f xs"
 >
 
 <xsl:import href="../f/func-binSearch.xsl"/>

<!--
     To be applied on ../data/test-binSearch10000N.xml
-->
 <xsl:output omit-xml-declaration="yes"/>
  
 <xsl:template match="/" >
   <xsl:variable name="vSeq" select="1 to 10000" as="xs:integer+"/>
   <xsl:for-each select="1 to 1000">
     <xsl:sequence 
     select="10000 + current(), 
              f:binSearch(f:eq(),f:lt(),
                          $vSeq, 
                          10000 + current(), 
                          1, 10000)"/>
     <xsl:text>&#xA;</xsl:text>
   </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>