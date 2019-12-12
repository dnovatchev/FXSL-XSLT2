<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:f="http://fxsl.sf.net/"
exclude-result-prefixes="f"
>

  <xsl:import href="../f/func-getWords.xsl"/>

   <!-- to be applied on ../data/othello.xml -->


   <xsl:output indent="yes" omit-xml-declaration="yes"/>
   
   <xsl:template match="/">
     <xsl:for-each select="//text()">
       <xsl:sequence select="f:getWords(string(.), ', &#9;&#10;&#13;', 1)"/>
     </xsl:for-each>
   </xsl:template>

</xsl:stylesheet>